source ~/.bash_profile

git reset --hard

result=`git pull | grep "Already up-to-date."`
if [ "Already up-to-date." == "$result" ]; then
    exit 0
fi

npm install

echo "begin deploy blog : "`date` >> deploy.log
hexo generate

cd ../hassanchiang.github.io/

git reset --hard

git pull

chmod +x ./deploy.sh

rsync -avz --delete /root/blog/blog/public/ /root/blog/hassanchiang.github.io/ --exclude=.git --exclude=CNAME --exclude=mind

git add . -A

git commit -m "$(date +%Y-%m-%d) $(date +%X)"

git push
