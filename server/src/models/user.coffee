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