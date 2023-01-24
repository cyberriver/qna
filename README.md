# README

This app to ask and asnwer the questions. 

ALl instalation is basic for rails app. 
App based on:
- rails framework
- Postgress BD
- Rspec as a test suite

Installation Guide
1. Install ruby 2.7.2 (pls check GemFile)
2. Install yarn (better ver 2)
3. Install postgresql and setup necessary user (pls check config.yml)
4. Install rails (6.1, pls check version in Gemfile)
5. Clone git repository
6. Run bundle and yarn
7. Install webpacker
8. Install node.js
9. Install bootstrap 5
10. Run bundler
11. Check packages by running yarn install
11. Run DB migrations by 
rails db:setup 
10. If you use test local environment for AJAX testing pls compile manually necessary JS, just run following command
NODE_ENV=test bundle exec rails webpacker:compile

After complication pls check that assets should appear at public/packs-test directory and run specs testing

11. To run UAT testing if you use Chrome, pls install actual Chrome driver for Selenium

After installation pls run rspec and check that everything works properly:
rspec spec/

