module.exports = (sequelize, DataTypes) ->
  sequelize.define('user',
    email: DataTypes.STRING
  )