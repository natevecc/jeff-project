

module.exports = (sequelize, DataTypes) ->
  sequelize.define('user',
    email: 
      type: DataTypes.STRING
      validate:
        isEmail: true
        notNull: true
        notEmpty: true
    password: 
      type: DataTypes.STRING(60)
      validate:
        isAlphanumeric: true
        notNull: true
        notEmpty: true
      toJson: false
  )