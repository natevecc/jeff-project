express = require 'express'
router = express.Router()

router.get (req, res) ->
  res.sendFile path.resolve(__dirname + '/../../client/index.html') # TODO make this configurable
  return