param(
  [Parameter(Mandatory = $false)]
  [ValidateRange(1, 5000000)]
  [int]$LineCount = 1000,

  [Parameter(Mandatory = $false)]
  [string]$OutputPath = "sample-generated.log"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$levels = @(
  @{ Name = "INFO"; Weight = 78 },
  @{ Name = "DEBUG"; Weight = 12 },
  @{ Name = "WARN"; Weight = 7 },
  @{ Name = "ERROR"; Weight = 3 }
)

$loggers = @(
  "c.n.guava",
  "c.n.auth",
  "c.n.cache",
  "c.n.http",
  "c.n.metrics",
  "c.n.orders",
  "c.n.payments",
  "c.n.search",
  "c.n.storage",
  "c.n.worker"
)

$messagesByLevel = @{
  INFO = @(
    "Application has been started",
    "Configuration has been loaded",
    "Health check completed successfully",
    "Cache warmup finished",
    "Incoming request has been handled",
    "Background job completed",
    "Database connection pool is ready",
    "Scheduled cleanup has finished"
  )
  DEBUG = @(
    "Refreshing access token for downstream client",
    "Resolved tenant configuration from cache",
    "Executing SQL query for current request",
    "Dispatching work item to background executor",
    "Skipping optional enrichment for anonymous user",
    "Preparing response payload for serialization"
  )
  WARN = @(
    "Retrying downstream request after timeout",
    "Slow query threshold has been exceeded",
    "Cache miss ratio is above expected baseline",
    "Received malformed optional header from client",
    "Thread pool utilization is above warning threshold"
  )
  ERROR = @(
    "Unhandled exception while processing request",
    "Failed to persist event to database",
    "Downstream service returned unexpected response",
    "Could not deserialize payload from message queue",
    "Request processing aborted due to missing dependency"
  )
}

$exceptionTypes = @(
  "java.lang.IllegalStateException",
  "java.lang.RuntimeException",
  "java.lang.NullPointerException",
  "java.sql.SQLTransientConnectionException",
  "com.example.RemoteServiceException"
)

$exceptionDetails = @(
  "Service returned an invalid state",
  "Unexpected null value while building response",
  "Connection pool exhausted during transaction",
  "Timed out while waiting for downstream response",
  "Message payload could not be parsed"
)

$stackFrames = @(
  "com.example.app.Service.handle(Service.java:184)",
  "com.example.app.Controller.process(Controller.java:77)",
  "com.example.app.Repository.save(Repository.java:213)",
  "com.example.app.QueueConsumer.accept(QueueConsumer.java:58)",
  "org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1027)",
  "org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)",
  "java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)",
  "java.base/java.lang.Thread.run(Thread.java:833)"
)

function Get-WeightedLevel {
  param([int]$Roll)

  $sum = 0
  foreach ($level in $levels) {
    $sum += $level.Weight
    if ($Roll -le $sum) {
      return $level.Name
    }
  }

  return "INFO"
}

function Get-RandomHex {
  param([int]$Length)

  $chars = "0123456789abcdef".ToCharArray()
  $builder = [System.Text.StringBuilder]::new($Length)
  for ($i = 0; $i -lt $Length; $i++) {
    [void]$builder.Append($chars[(Get-Random -Minimum 0 -Maximum $chars.Length)])
  }
  return $builder.ToString()
}

function Get-RandomMessage {
  param([string]$Level)

  $messages = $messagesByLevel[$Level]
  return $messages[(Get-Random -Minimum 0 -Maximum $messages.Count)]
}

function Write-ErrorStackTrace {
  param(
    [System.IO.StreamWriter]$Writer
  )

  $exceptionType = $exceptionTypes[(Get-Random -Minimum 0 -Maximum $exceptionTypes.Count)]
  $exceptionDetail = $exceptionDetails[(Get-Random -Minimum 0 -Maximum $exceptionDetails.Count)]
  $frameCount = Get-Random -Minimum 4 -Maximum 8

  $Writer.WriteLine("${exceptionType}: $exceptionDetail")
  for ($frameIndex = 0; $frameIndex -lt $frameCount; $frameIndex++) {
    $frame = $stackFrames[(Get-Random -Minimum 0 -Maximum $stackFrames.Count)]
    $Writer.WriteLine("    at $frame")
  }

  if ((Get-Random -Minimum 0 -Maximum 100) -lt 35) {
    $causeType = $exceptionTypes[(Get-Random -Minimum 0 -Maximum $exceptionTypes.Count)]
    $causeDetail = $exceptionDetails[(Get-Random -Minimum 0 -Maximum $exceptionDetails.Count)]
    $Writer.WriteLine("Caused by: ${causeType}: $causeDetail")
    $causeFrames = Get-Random -Minimum 2 -Maximum 5
    for ($causeIndex = 0; $causeIndex -lt $causeFrames; $causeIndex++) {
      $frame = $stackFrames[(Get-Random -Minimum 0 -Maximum $stackFrames.Count)]
      $Writer.WriteLine("    at $frame")
    }
  }
}

$outputFile = if ([System.IO.Path]::IsPathRooted($OutputPath)) {
  $OutputPath
} else {
  Join-Path -Path (Get-Location) -ChildPath $OutputPath
}

$start = [datetime]"2026-04-15T10:12:32.321"
$writer = [System.IO.StreamWriter]::new($outputFile, $false, [System.Text.UTF8Encoding]::new($false))

try {
  for ($i = 0; $i -lt $LineCount; $i++) {
    $timestamp = $start.AddMilliseconds($i * (Get-Random -Minimum 15 -Maximum 180))
    $level = Get-WeightedLevel -Roll (Get-Random -Minimum 1 -Maximum 101)
    $traceId = Get-RandomHex -Length 15
    $threadId = Get-Random -Minimum 1 -Maximum 17
    $logger = $loggers[(Get-Random -Minimum 0 -Maximum $loggers.Count)]
    $message = Get-RandomMessage -Level $level

    $line = "{0}    {1,-5} {2}  [thread-{3}] {4,-12} {5}" -f `
      $timestamp.ToString("yyyy-MM-dd HH:mm:ss.fff"), `
      $level, `
      $traceId, `
      $threadId, `
      $logger, `
      $message

    $writer.WriteLine($line)

    if ($level -eq "ERROR") {
      Write-ErrorStackTrace -Writer $writer
    }
  }
}
finally {
  $writer.Dispose()
}

Write-Host "Generated $LineCount log lines:"
Write-Host $outputFile
