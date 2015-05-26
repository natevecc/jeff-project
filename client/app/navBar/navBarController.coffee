
module.exports = class NavBar
  @$inject = [
    '$rootScope'
    '$state'
  ]
  constructor: (@$rootScope, @$state) ->
    @$rootScope.$on '$stateChangeStart', 
      (event, toState, toParams, fromState, fromParams) =>
        if not @$rootScope.loggedIn and toState.name != 'login'
          event.preventDefault()
          @$state.go('login')

  logoutPrompt: () ->
    console.log 1

  logout: () ->
    $http.delete "/api/sessions"
    .then (res) =>
      @$rootScope.loggedIn = false
      @$state.go('login')
