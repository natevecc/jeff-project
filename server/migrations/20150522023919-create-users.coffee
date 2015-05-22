module.exports =
  up: (queryInterface, Sequelize) ->
    return queryInterface.createTable('users',
      id: 
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      email: Sequelize.STRING
      created_at: Sequelize.DATE
      updated_at: Sequelize.DATE
      deleted_at: Sequelize.DATE
      )
  down: (queryInterface, Sequelize) ->
    return queryInterface.dropTable('users');
