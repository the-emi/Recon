# Wayback URLs Fetcher

A PowerShell script to fetch archived URLs of a domain from the Wayback Machine (web.archive.org) with optional filtering by multiple patterns.

---

## Features

* Fetch all archived URLs for a given domain.
* Filter URLs by one or more patterns (e.g., `.php`, `/admin`, `.jpg`).
* Save filtered URLs to a file (`filtered-urls.txt`).
* Display all URLs if no filter is provided.

---

## Requirements

* PowerShell (version 5 or higher recommended)
* Internet connection

---

## Usage

### Run the script without filtering:

```powershell
.\Recon.ps1 -Domain "example.com"
```

This command fetches and displays all archived URLs for `example.com`.

---

### Run the script with filtering (one or more patterns):

```powershell
.\Recon.ps1 -Domain "example.com" -FilterPatterns ".php", "/admin", ".jpg"
```

This command fetches URLs containing **any** of the specified patterns and saves them to `filtered-urls.txt` in the script directory.

---

## Output

* Filtered URLs are saved to `filtered-urls.txt`.
* If no filter patterns are specified, all URLs are printed to the console.

---

## Notes

* Ensure your PowerShell execution policy allows script execution. To set this, run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

* The script uses the [Wayback Machine CDX API](https://archive.org/help/wayback_api.php) to fetch archived URLs.

---

## License

This project is licensed under the MIT License.


````markdown
# PowerShell URL Requester with Burp Proxy Support

This script reads URLs from a text file and sends HTTP GET requests to each URL.  
Requests are routed through a Burp Suite proxy running at `http://127.0.0.1:8080` for inspection.

---

## Usage

1. Put your list of URLs into a text file (e.g., `urls.txt`), each URL on a separate line or embedded in text.

2. Run the script:

```powershell
.\get.ps1 -InputFile "urls.txt"
````

---

## Adding Burp Suite CA Certificate

To avoid SSL errors when making HTTPS requests through Burp, you need to add Burp's CA certificate to your system’s trusted root certificates.

### Steps to add Burp CA:

1. Open Burp Suite and go to **Proxy > Options**.

2. Click **Import / export CA certificate** and export the certificate in `DER` or `PEM` format.

3. Install the CA certificate on Windows:

   * Right-click the certificate file and choose **Install Certificate**.
   * Select **Local Machine** (Administrator rights required).
   * Choose **Place all certificates in the following store** and select **Trusted Root Certification Authorities**.
   * Complete the installation wizard.

4. Restart your browsers and tools to apply the new trusted CA.

---

## Notes for Running the Script with CA

If you encounter SSL errors while running the script:

* Make sure Burp’s CA certificate is added as above.
* Alternatively, disable SSL verification in requests (not recommended and tricky in PowerShell).

---

## Parameters

| Parameter   | Description                      | Default    |
| ----------- | -------------------------------- | ---------- |
| `InputFile` | Path to the file containing URLs | `urls.txt` |

---

## Technical Details

* Requests are sent sequentially with a random delay between 50 to 200 milliseconds.
* The Burp proxy is set at `http://127.0.0.1:8080` and passed to `Invoke-WebRequest` via the `-Proxy` parameter.

---

## Troubleshooting

* If the script doesn’t run, ensure you are in the correct directory or provide the full script path.
* You might need to change the PowerShell execution policy:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Example usage

```powershell
.\get.ps1 -InputFile "C:\Users\OMEN\Desktop\filtered-urls.txt"
```
