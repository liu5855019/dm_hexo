# mac
# source ./publish.sh

pwd;

echo "start public";

hexo g


echo "start cp";
\cp -R -f ./public/ ../liu5855019.github.io/
echo "end cp";

