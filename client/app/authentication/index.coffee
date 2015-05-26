angular = require 'angular'
modal = require './modal.logout.html'

class Authentication
  @$inject = [
    '$rootScope'
    '$state'
    '$modal'
    '$q'
    '$http'
    '$cookieStore'
  ]

  constructor: (@$rootScope, @$state, @$modal, @$q, @$http, @$cookieStore) ->
    if @$cookieStore.get 'user'
      @$rootScope.user = angular.fromJson(@$cookieStore.get 'user')
      @$state.go 'home'
    else
      @$rootScope.user = null

    @$rootScope.$on '$stateChangeStart', 
      (event, toState, toParams, fromState, fromParams) =>
        if not @$rootScope.user and not (toState.name is 'login' or toState.name is 'register')
          event.preventDefault()
          @$state.go 'login'

  logout: () ->
    modalInstance = @$modal.open
      animation: true
      templateUrl: '/authentication/modal.logout.html'
      size: 'sm'

    modalInstance.result
    .then (logoutIntent) =>
      if logoutIntent
        return @$http.delete "/api/sessions"
      else
        return @$q.reject()
    .then (res) =>
      @$rootScope.user = null
      @$cookieStore.remove 'user'
      @$state.go 'login'

  login: (email, password) ->
    @$http.post('/api/sessions', {email: email, password: password})
    .then (res) =>
      # success and redirect to root
      @$rootScope.user = res.data
      @$state.go('home')

  register: (options) ->
    @$http.post('/api/users', options)
    .then (res) =>
      # success and redirect to root
      @$rootScope.user = res.data
      @$state.go('home')

module.exports = angular.module('jeff-app.authentication', [
  require 'angular-ui-router'
  require 'angular-bootstrap-npm'
  require 'angular-cookies'
])
.service 'authentication', Authentication