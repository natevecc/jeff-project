Promise = require('bluebird');

module.exports =
  up: (queryInterface, Sequelize) ->
    Promise.join [
      queryInterface.addColumn 'users', 'first_name', 
        type: Sequelize.STRING
        allowNull: false
      queryInterface.addColumn 'users', 'last_name', 
        type: Sequelize.STRING
        allowNull: false
      queryInterface.addColumn 'users', 'role', 
        type: Sequelize.STRING
        allowNull: false
    ]
  
  down: (queryInterface, Sequelize) ->
    Promise.join [
      queryInterface.removeColumn 'users', 'first_name'
      queryInterface.removeColumn 'users', 'last_name'
      queryInterface.removeColumn 'users', 'role'
    ]
