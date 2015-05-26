module.exports = [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider) ->
    
    $locationProvider.html5Mode(true).hashPrefix('!');

    $urlRouterProvider.otherwise("/login");

    $stateProvider
    .state 'home',
      url: '/'
      controller: 'homeController'
      templateUrl: '/home/home.html'
    .state 'login',
      url: '/login'
      controller: 'loginController'
      templateUrl: '/login/login.html'
  ]