$targetDomain = "speedtest.lfa.one"

$timestamp = $(get-date -f yyyy-MM-dd_HHmmss)
$logFile = "logs/${timestamp}.json"
$scriptLogFile = "logs/${timestamp}.script.log"

mkdir "logs" -ErrorAction SilentlyContinue | Out-Null

Start-Transcript -path "${scriptLogFile}"

Write-Output "Executing speed test for ${targetDomain}"
Write-Output "Log file is ${logFile}"
Write-Output "Transcript is ${scriptLogFile}"
Write-Output ""

function Run-UDP([Int] $Bandwidth) {
  $BandwidthMB = $Bandwidth * 0.000001
  Write-Output "Running $BandwidthMB MBits/sec UDP for 30 seconds"
  ./lib/iperf3.exe -c "${targetDomain}" --logfile "${logFile}" --format M --bandwidth $Bandwidth --time 30 --json --verbose --udp
  if ($LASTEXITCODE -ne 0) {
    Write-Output "Test failed."
    Write-Output "See: https://github.com/AULFA/speedtest#one-or-more-tests-failed"
  }
}

$udpRates = @(1000, 2000, 10000, 20000, 100000, 200000, 1000000, 2000000, 10000000, 20000000, 100000000, 200000000)

$timeExpected = $udpRates.Count * 0.5

Write-Output "Tests will be completed in approximately ${timeExpected} minutes"
Write-Output ""

foreach ($rate in $tcpRates) {
  Run-UDP $rate
}

Stop-Transcript

Write-Output "Tests completed"
Read-Host "Press ENTER to exit"
