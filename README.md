# README

This app to ask and asnwer the questions. 
# **Tech Stack**
ALl instalation is basic for rails app. 
App based on:
- rails framework (ruby, rvm)
- Postgress BD
- Rspec as a test suite
- Ubuntu 20.04

# **Installation Guide** <br>
1. Install ruby 2.7.2 (pls check GemFile)

## Install Ruby Version manager (RVM or Rbenv)
> sudo apt update
> sudo apt install curl g++ gcc autoconf automake bison libc6-dev \ libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \ libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \ libreadline-dev libssl-dev
> curl -sSL https://rvm.io/mpapis.asc | gpg --import -
> curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
> curl -sSL https://get.rvm.io | bash -s stable

in a case of issues with OpenSSL3 pls run
### OpenSSL3 installation
> sudo apt install openssl
install openssl3 dependecies
> sudo apt install build-essential checkinstall zlib1g-dev -y
download openssl3
> cd /usr/local/src/
> wget https://www.openssl.org/source/openssl-3.0.2.tar.gz
> sudo tar -xvf openssl-3.0.2.tar.gz

check openssl ver 
> openssl version -a
> ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
> make
> make test
> make install
> cd /etc/ld.so.conf.d/
> sudo nano openssl-3.0.2.conf
> sudo ldconfig -v
> mv /usr/bin/c_rehash /usr/bin/c_rehash.BEKUP
> mv /usr/bin/openssl /usr/bin/openssl.BEKUP
> sudo nano /etc/environment

Add /usr/local/ssl/bin to the end of your PATH environment variable.
> PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/ssl/bin"

save and exit 
> source /etc/environment
> echo $PATH
> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/ssl/bin

### Repeat Installation rvm or rvenv mentioned above

> source ~/.rvm/scripts/rvm

> rvm list known
> rvm install ruby-2.7.2
> rvm use ruby-2.7.2
> ruby -v

2. Install yarn (better ver 2)
> curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
> echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
> sudo apt update
> sudo apt install yarn
> yarn --version

migration to yarn 2
> npm install -g yarn
> yarn set version berry
If you used .npmrc or .yarnrc, you'll need to turn them into the new format (see also 1, 2) ,pls check here 
https://yarnpkg.com/configuration/yarnrc
Add nodeLinker: node-modules in your .yarnrc.yml file
Run yarn to migrate nodelinker
> yarn install

3. Install postgresql and setup necessary user (pls check config.yml)

### Installation for Ubuntu 20.04

> sudo apt update && sudo apt upgrade
> sudo apt install postgresql postgresql-contrib
after pls check
> psql --version

to start psql service pls run
> sudo service postgresql start

to check status
> sudo service postgresql status
> sudo service postgresql stop

To create the proper user
> sudo -u postgres psql
> create user USER_NAME password 'PASSWORD';

4. Install rails (6.1, pls check version in Gemfile)
> sudo apt update
> gem install rails -v 6.1.7


5. Install node.js
> sudo apt install nodejs


6. Clone git repository
> git clone https://github.com/cyberriver/qna.git

7. Run bundle and install nececcary gems
> bundle install

### in a case if webpacker required dependencies
install dependencies for webpacker

> curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
> curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
> echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

> sudo apt-get update
> sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn


8. Install bootstrap 5
> yarn add bootstrap jquery popper.js

10. Check  in a case update packages by running yarn install
> yarn install

11. Create DB for application and Run DB migrations by 
> rails db:setup 

in a case errors with connections pls restart psql by:
> sudo service postgresql start

10. If you use test local environment for AJAX testing pls compile manually necessary JS, just run following command
### pls note that webpacker doesn't compile packs for test enviromnet no matter that you set in its config
### and you need it to do manually by
> NODE_ENV=test bundle exec rails webpacker:compile

After complication pls check that assets should appear at public/packs-test directory and run specs testing

11. To run UAT testing if you use Chrome, pls install actual Chrome driver for Selenium

## instruction for Capybara gem
> https://gist.github.com/danwhitston/5cea26ae0861ce1520695cff3c2c3315

### Installing stable Chrome
> sudo apt update
> sudo apt install -y unzip xvfb libxi6 libgconf-2-4 
> sudo apt install default-jdk 
> sudo apt install wget
> wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
> sudo dpkg -i google-chrome-stable_current_amd64.deb
> sudo apt-get install -f
> google-chrome --version

### Install Chromedriver
> wget https://chromedriver.storage.googleapis.com/92.0.4515.107/chromedriver_linux64.zip
> unzip chromedriver_linux64.zip
> sudo mv chromedriver /usr/bin/chromedriver
> sudo chown root:root /usr/bin/chromedriver
> sudo chmod +x /usr/bin/chromedriver

### download required jar files
> wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar 
> mv selenium-server-standalone-3.141.59.jar selenium-server-standalone.jar 
> wget http://www.java2s.com/Code/JarDownload/testng/testng-6.8.7.jar.zip 
> unzip testng-6.8.7.jar.zip 

### Start selenium server to test
> xvfb-run java -Dwebdriver.chrome.driver=/usr/bin/chromedriver -jar selenium-server-standalone.jar 
> chromedriver --url-base=/wd/hub 


After installation pls run rspec and check that everything works properly:
rspec spec/

