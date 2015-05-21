module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable('Users', 
      email: DataTypes.STRING
      ).complete done
    return
  down: (migration, DataTypes, done) ->
    migration.dropTable('Users').complete done
    return