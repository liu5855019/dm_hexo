# mac
# source ./publish.sh

pwd;

echo "start public";

hexo g


echo "start cp";
\cp -R -f ./public/ ../liu5855019.github.io/
echo "end cp";



# Set-Location ..\liu5855019.github.io
# Get-Location

# git status
# git add .
# git commit -a -m "update"

