$ErrorActionPreference = 'Stop'

$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$javaExe = 'C:\java\jdk8\bin\java.exe'
$jar = Join-Path $projectDir 'build\libs\infolens-java8-api-1.0.0.jar'
$outLog = Join-Path $projectDir 'run-out.log'
$errLog = Join-Path $projectDir 'run-err.log'

if (-not (Test-Path $javaExe)) {
    throw "Java 8 was not found at $javaExe"
}

if (-not (Test-Path $jar)) {
    Push-Location $projectDir
    try {
        & .\gradlew.bat bootJar --no-daemon --console=plain
        if ($LASTEXITCODE -ne 0) {
            throw 'Gradle bootJar failed.'
        }
    } finally {
        Pop-Location
    }
}

Remove-Item $outLog, $errLog -Force -ErrorAction SilentlyContinue
$argumentList = @('-jar', ('"{0}"' -f $jar))
$proc = Start-Process -FilePath $javaExe `
    -ArgumentList $argumentList `
    -WorkingDirectory $projectDir `
    -RedirectStandardOutput $outLog `
    -RedirectStandardError $errLog `
    -PassThru

try {
    $response = $null
    for ($i = 0; $i -lt 30; $i++) {
        Start-Sleep -Seconds 1
        if ($proc.HasExited) {
            throw "Application exited with code $($proc.ExitCode). See $errLog"
        }
        try {
            $response = Invoke-WebRequest `
                -Uri 'http://localhost:8080/api/v1/hello' `
                -UseBasicParsing `
                -TimeoutSec 2 `
                -ErrorAction Stop
            break
        } catch {
            # The server may still be starting.
        }
    }

    if ($null -eq $response) {
        throw "Application did not start within 30 seconds. See $outLog and $errLog"
    }

    Write-Output "SUCCESS - HTTP $([int]$response.StatusCode)"
    Write-Output $response.Content
} finally {
    if ($proc -and -not $proc.HasExited) {
        Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
    }
}
