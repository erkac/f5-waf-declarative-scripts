#!/bin/sh

echo
echo "Hi! I'm a Git repository of our dear developers :-)"
echo 
echo "I'll be serving WAF Policy..."
echo

python3 -m http.server --cgi 8282
