angular = require 'angular'
NavBar = require './navBarController'
logoutModal = require './modal.logout.html'

module.exports = angular.module('jeff-app.navBar', [
  'templates'
  require('../authentication').name
  ])
.controller 'navBarController', NavBar