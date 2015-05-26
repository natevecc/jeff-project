
module.exports = class NavBar
  @$inject = [
    'authentication'
    '$rootScope'
  ]
  constructor: (@authentication, @$rootScope) ->
