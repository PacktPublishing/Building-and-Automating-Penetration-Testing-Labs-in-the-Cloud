echo "Sleeping for 60 seconds"
sleep 60

mkdir files
cd files

SOURCE=https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch03/sample_website.zip
wget $SOURCE -O sample_website.zip

unzip sample_website.zip
rm sample_website.zip

aws s3 cp -–recursive . s3://$1