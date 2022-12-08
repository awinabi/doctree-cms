##
# AWS machine which is used to run docker images
#
##


#### #### #### Make Swapfile
sudo apt-get update
sudo apt-get upgrade
sudo su -

dd if=/dev/zero of=/swapfile bs=500M count=3
ls -lh /swapfile
chown root:root /swapfile
chmod 0600 /swapfile

mkswap /swapfile
swapon /swapfile

echo "/swapfile none            swap    sw              0       0" >> /etc/fstab

#### #### #### Install packages
sudo apt-get -y install aptitude git-core curl zlib1g-dev build-essential sqlite3 
sudo apt-get -y install docker.io docker docker-compose

#### #### #### Add ubuntu to docker group
sudo su - ubuntu
sudo usermod -aG docker $USER 

#### #### #### Get Code
ssh-keygen -t ed25519 -C "awin-temp@strapiserver"
cat ~/.ssh/id_ed25519.pub

## Add the key to gitlab
ssh -T git@github.com

git clone git@github.com:awinabi/linktree-cms.git

#### #### #### Docker build
cd linktree-cms
# copy .env to .env
docker-compose up # test run and create database etc

# fix issues if any

# Run production
docker-compose up -d

#### #### #### Docker commands
docker ps
docker images
