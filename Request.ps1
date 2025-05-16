param(
    [string]$InputFile = "urls.txt"
)

$proxyUrl = "http://127.0.0.1:8080"

$content = Get-Content $InputFile -Raw
$regex = '(http|https)://[^\s"]+'
$matches = [regex]::Matches($content, $regex)

foreach ($match in $matches) {
    $url = $match.Value
    try {
        Write-Host "Sending GET request to: $url"

        # مستقیم رشته آدرس پروکسی رو به پارامتر Proxy می‌دیم
        $response = Invoke-WebRequest -Uri $url -Proxy $proxyUrl -UseBasicParsing

        Write-Host "Request succeeded."
    }
    catch {
        Write-Host "Error requesting $url : $_"
    }

    # Delay between 50 to 200 milliseconds
    $delay = Get-Random -Minimum 50 -Maximum 201
    Start-Sleep -Milliseconds $delay
}
