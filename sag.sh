dl() {
wget https://raw.githubusercontent.com/rooted-cyber/sa-genrated/main/generate_drive_token.py
wget https://raw.githubusercontent.com/rooted-cyber/sa-genrated/main/gen_sa_accounts.py
}
gns() {
printf "\n Generate sa files\n"
printf "\n\033[1;93m project list\n"
python gen_sa_accounts.py --list-projects
echo
echo -e -n "\033[1;92m Enter project name :\033[0m "
read n
if [ "$n" ];then
python gen_sa_accounts.py --enable-services $n
python gen_sa_accounts.py --create-sas $n
python gen_sa_accounts.py --download-keys $n
fi
if [ -e accounts ];then
zip || apt install zip
zip -9 -r accounts accounts
cd accounts
grep -oPh '"client_email": "\K[^"]+' *.json > emails.txt
fi
cd ~/mbot
cp -rf token* accou* /sdcard/sa_files
}
gen() {
cd /sdcard
if [ -e "sa_files" ];then
echo
else
printf "\n First setup storage permission !!\n\n\n"
exit
fi
cd /sdcard/sa_files
if [ -e "credentials.json" ];then
cd /sdcard/sa_files
cp -f credentials.json ~/mbot
cd ~/mbot
dl
printf "\n Generating token.pickle\n"
python generate_drive_token.py
gns
else
printf "\n First copy \033[0m crendentials.json in /sdcard/sa_files\n"
exit
fi
}

ins() {
apt update
apt upgrade
apt install --fix-broken
apt install wget
apt install python || apt reinstall python
apt install --fix-broken
pip install --upgrade pip
pip install google_auth_oauthlib
pip install google-api-python-client
pip install google-auth-httplib2
termux-setup-storage
mkdir /sdcard/sa_files
mkdir ~/mbot
gen
}
start() {
echo -e -n "\033[1;93m Install Requirements (y|n) "
read a
case $a in
y|Y)ins ;;
n|N)gen ;;
*)start ;;
esac
}
start