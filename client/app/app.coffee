angular = require 'angular'
uiRouter = require 'angular-ui-router'

module.export = angular.module("jeff-app", [uiRouter])
  .controller "test", () ->
    @name = "tester"
    @value = "theValue"