
module.exports = class Home
  @$inject = [
    "$rootScope"
    '$http'
  ]
  constructor: (@$rootScope, @$http) ->
    @user = @$rootScope.user
    
    @showUsers = false
    @buttonText = "Show Users"

    if @user.role is 'admin'
      @$http.get('/api/users')
      .then (res) =>
        @users = res.data

  toggleUsers: () ->
    @showUsers = !@showUsers
    if @showUsers
      @buttonText = "Hide All Users"
    else
      @buttonText = "Show All Users"