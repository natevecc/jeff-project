module.exports = [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  '$httpProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->

    $httpProvider.defaults.withCredentials = true
    
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
    .state 'register',
      url: '/register'
      controller: 'registerController'
      controllerAs: 'register'
      templateUrl: '/register/register.html'
  ]