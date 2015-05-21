module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', { username: DataTypes.STRING }, classMethods: associate: (models) ->
    User.hasMany models.Task
    return
  )
  User