# Test-403
## Overview

Bypass-403 is a Bash script designed to test for 403 Bypass vulnerabilities on a specified URL path. It includes various tests to check for common bypass techniques.

## Usage


```
./test-403.sh <url> <path> [options: -w|--no-wayback] [-h|--help]
```
Options
-w, --no-wayback: Skip Wayback Machine URL check
-h, --help: Show this help message
Examples
  ```
./bypass-403.sh https://example.com /admin
```
Tests Performed
.Empty path
.Path containing /../
.Path ending with /./
.Double slash // in the path
.Various headers like X-Original-URL, X-Custom-IP-Authorization, etc.
.URL encoding tests
.Additional tests for common security misconfigurations
./etc/passwd inclusion
.Tilde (~) access
.git directory configuration
.WEB-INF directory checks
.svn directory entries
.DS_Store file
.Various encoded path variations

Wayback Machine
The script checks the Wayback Machine for the provided URL path by default. Use the -w option to skip this check.

Dependencies
`curl`
`jq`
License
This script is licensed under the MIT License.

Make sure to replace `<url>` and `<path>` placeholders with actual values in your usage examples. Feel free to adjust or expand the content based on your specific requirements.
