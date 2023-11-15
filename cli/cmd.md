# Commands

## Check compression

```fish
# regular
curl <url> --silent --write-out "%{size_download}\n" --output /dev/null

# compressed
curl <url> --silent -H "Accept-Encoding: gzip,deflate" --write-out "%{size_download}\n" --output /dev/null
```