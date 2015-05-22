module.exports = (sequelize, DataTypes) ->
  sequelize.define('User',
    email: DataTypes.STRING
  ,  
    timestamps: true
    paranoid: true
  )