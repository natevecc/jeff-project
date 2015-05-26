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
      controllerAs: 'home'
      templateUrl: '/home/home.html'
    .state 'login',
      url: '/login'
      controller: 'loginController'
      controllerAs: 'login'
      templateUrl: '/login/login.html'
  ]