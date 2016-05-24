This script downloads all photos from given Facebook album to the specified folder on local file system.

# OS
This script was tested on MAC OS El Capitan, but should be working on any Linux distribution.

# Dependencies
* jq - command-line JSON processor: https://stedolan.github.io/jq/download/

# Installation
1. Download the `fb.sh` script and make it executable:
```
chmod +x fb.sh
```
2. Go to Facebook to generate the Access Token (TODO: more details should be added here)
3. Write the Access Token to the `.fb_access_token`:
```
echo $accessToken > .fb_access_token
```

# Usage
```
fb.sh $album_id ~/path/to/my/photos
```

# Roadmap
* Get Facebook Access Token
* Better error handling
* Better CLI interface/arguments handling
