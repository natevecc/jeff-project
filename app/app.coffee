express = require('express')

app = module.exports = express()
app.use express.static('public')

app.get '/', (req, res) ->
  res.send 'Hello World!'
  return

server = app.listen(3000, ->
  host = server.address().address
  port = server.address().port
  console.log 'jeff-project listening at http://%s:%s', host, port
  return
)