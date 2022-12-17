
Get-Location

Write-Output "start public";

hexo g


Write-Output "start cp";
Copy-Item .\public\* ..\liu5855019.github.io -Recurse -Force;
Write-Output "end cp";

# Set-Location ..\liu5855019.github.io
# Get-Location

# git status
# git add .
# git commit -a -m "update"

