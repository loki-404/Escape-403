# Test-403
## Overview

Bypass-403 is a Bash script designed to test for 403 Bypass vulnerabilities on a specified URL path. It includes various tests to check for common bypass techniques.

## Usage


```
./test-403.sh <url> <path> [options: -w|--no-wayback] [-h|--help]
```
##Options

-w, --no-wayback: Skip Wayback Machine URL check<br>
-h, --help: Show this help message

##Examples
  ```
./bypass-403.sh https://example.com /admin
```
##Tests Performed
.Empty path<br>
.Path containing /../<br>
.Path ending with /./<br>
.Double slash // in the path<br>
.Various headers like X-Original-URL, X-Custom-IP-Authorization, etc.<br>
.URL encoding tests<br>
.Additional tests for common security misconfigurations<br>
./etc/passwd inclusion<br>
.Tilde (~) access<br>
.git directory configuration<br>
.WEB-INF directory checks<br>
.svn directory entries<br>
.DS_Store file<br>
.Various encoded path variations<br>

Wayback Machine
The script checks the Wayback Machine for the provided URL path by default. Use the -w option to skip this check.

Dependencies<br>
`curl`<br>
`jq`<br>

##License
This script is licensed under the MIT License.

Make sure to replace `<url>` and `<path>` placeholders with actual values in your usage examples. Feel free to adjust or expand the content based on your specific requirements.
