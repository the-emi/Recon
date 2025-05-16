# param (
#     [Parameter(Mandatory=$true)]
#     [string]$Domain
# )

# # Remove http or https from input if present
# $CleanDomain = $Domain -replace '^https?://', ''

# # Construct API URL
# $apiUrl = "https://web.archive.org/cdx/search/cdx/?url=*.$CleanDomain&fl=original&collapse=urlkey"

# Write-Host "Sending request to:"
# Write-Host $apiUrl -ForegroundColor Cyan

# # Fetch data from the Wayback Machine CDX API
# try {
#     $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
#     $urls = $response.Content -split "`n"

#     Write-Host "`nArchived URLs for domain '$CleanDomain':`n"

#     foreach ($url in $urls) {
#         if ($url.Trim() -ne "") {
#             Write-Host $url
#         }
#     }
# }
# catch {
#     Write-Error "Failed to retrieve data from the archive: $_"
# }

#v2

# param (
#     [Parameter(Mandatory=$true)]
#     [string]$Domain,

#     [Parameter(Mandatory=$true)]
#     [string]$FilterPattern
# )

# # Clean domain input
# $CleanDomain = $Domain -replace '^https?://', ''

# # Construct API URL
# $apiUrl = "https://web.archive.org/cdx/search/cdx/?url=*.$CleanDomain&fl=original&collapse=urlkey"

# Write-Host "Fetching archived URLs for domain: $CleanDomain"
# Write-Host "Using filter pattern: '$FilterPattern'"
# Write-Host "Sending request to: $apiUrl`n" -ForegroundColor Cyan

# try {
#     # Request data
#     $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
#     $urls = $response.Content -split "`n"

#     # Apply filter
#     $filteredUrls = $urls | Where-Object { $_ -like "*$FilterPattern*" }

#     # Save to file
#     $outputFile = "filtered-urls.txt"
#     $filteredUrls | Out-File -FilePath $outputFile -Encoding utf8

#     Write-Host "`n✅ Done. Found $($filteredUrls.Count) matching URLs."
#     Write-Host "Results saved to: $outputFile"
# }
# catch {
#     Write-Error "Failed to process request: $_"
# }

#v2.1

# param (
#     [Parameter(Mandatory=$true)]
#     [string]$Domain,

#     [Parameter(Mandatory=$false)]
#     [string]$FilterPattern
# )

# $CleanDomain = $Domain -replace '^https?://', ''
# $apiUrl = "https://web.archive.org/cdx/search/cdx/?url=*.$CleanDomain&fl=original&collapse=urlkey"

# Write-Host "Fetching archived URLs for domain: $CleanDomain"
# if ($FilterPattern) {
#     Write-Host "Using filter pattern: '$FilterPattern'"
# }
# Write-Host "Requesting: $apiUrl`n" -ForegroundColor Cyan

# try {
#     $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
#     $urls = $response.Content -split "`n" | Where-Object { $_.Trim() -ne "" }

#     if ($FilterPattern) {
#         $filteredUrls = $urls | Where-Object { $_ -like "*$FilterPattern*" }
#         $outputFile = "filtered-urls.txt"
#         $filteredUrls | Out-File -FilePath $outputFile -Encoding utf8

#         Write-Host "Found $($filteredUrls.Count) matching URLs."
#         Write-Host "Saved to: $outputFile"
#     } else {
#         Write-Host "All archived URLs for '$CleanDomain':"
#         foreach ($url in $urls) {
#             Write-Host $url
#         }
#     }
# } catch {
#     Write-Error "Error: $_"
# }

#v2.2

param (
    [Parameter(Mandatory=$true)]
    [string]$Domain,

    [Parameter(Mandatory=$false)]
    [string[]]$FilterPatterns  # آرایه از رشته‌ها
)

$CleanDomain = $Domain -replace '^https?://', ''
$apiUrl = "https://web.archive.org/cdx/search/cdx/?url=*.$CleanDomain&fl=original&collapse=urlkey"

Write-Host "Fetching archived URLs for domain: $CleanDomain"

if ($FilterPatterns) {
    Write-Host "Using filter patterns:"
    foreach ($pattern in $FilterPatterns) {
        Write-Host " - $pattern"
    }
}

Write-Host "Requesting: $apiUrl`n" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
    $urls = $response.Content -split "`n" | Where-Object { $_.Trim() -ne "" }

    if ($FilterPatterns) {
        # فقط URLهایی که حداقل یکی از پترن‌ها را داشته باشند
        $filteredUrls = $urls | Where-Object {
            $url = $_
            foreach ($pattern in $FilterPatterns) {
                if ($url -like "*$pattern*") {
                    return $true
                }
            }
            return $false
        }

        $outputFile = "filtered-urls.txt"
        $filteredUrls | Out-File -FilePath $outputFile -Encoding utf8

        Write-Host "Found $($filteredUrls.Count) matching URLs."
        Write-Host "Saved to: $outputFile"
    } else {
        Write-Host "All archived URLs for '$CleanDomain':"
        foreach ($url in $urls) {
            Write-Host $url
        }
    }
} catch {
    Write-Error "Error: $_"
}
