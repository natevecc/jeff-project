# jeff-project
An sample application involving Angular, Express, Sequelize, Gulp and Vagrant 

## Currently Only supports dev mode

## Setup Instructions

### Install Dev environment dependencies
 - Virtual Box
   - [download](https://www.virtualbox.org/wiki/Downloads) and install
   - or on a mac with [homebrew](http://brew.sh/): `brew install virtualbox`
 - Vagrant
   - [download](https://www.vagrantup.com/downloads.html) and install
   - or `brew install vagrant`
 - Vagrant Berkshelf plugin
   - `vagrant plugin install vagrant-berkshelf`
 - Vagrant Omnibus plugin
   - `vagrant plugin install vagrant-omnibus`

### Setup Dev Box
 After cloning the repository cd into it and run vagrant up: `cd /jeff-app` `vagrant up`
 
 Ths will download the vagrant image, start the server and provision it with all of it's dev dependencies
 
 Use `vagarnt ssh` to log onto the machine
 
 `cd /vagrant` to get to the code and `gulp` to start the server which you can reach by navigating to `localhost:3000` from your browser.
