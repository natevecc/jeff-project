_ = require 'lodash'

module.exports = (sequelize, DataTypes) ->
  sequelize.define('user',
    email: 
      type: DataTypes.STRING
      validate:
        isEmail: true
        notEmpty: true
    password: 
      type: DataTypes.STRING(60)
      validate:
        notEmpty: true
    firstName:
      type: DataTypes.STRING
      field: 'first_name'
      validate:
        notEmpty: true
    lastName:
      type: DataTypes.STRING
      field: 'last_name'
      validate:
        notEmpty: true
    role:
      type: DataTypes.STRING
      validate:
        notEmpty: true

  ,
    instanceMethods: 
      toJSON: ->
        obj = this.get
          plain: true
        clone = _.clone(obj, true) 
        delete clone.password
        delete clone.deletedAt
        clone
  )