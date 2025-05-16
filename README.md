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
