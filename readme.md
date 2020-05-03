# GitHub Pages

Enqueues a GitHub Pages build and watches its building progress until the
deployment is built.

## Running

```powershell
ubuntu
cd /mnt/c/Users/TomasHubelbauer/Desktop/github-pages
./deploy.sh
```

## FYI

GitHub Pages does not support URLs starting with an underscore. Requests
to such locations will result in a 404 response. This is likely a Jekyll
feature?
