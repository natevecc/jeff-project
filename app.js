require('coffee-script/register');
app = require('./server/src/server.coffee');

var server;
server = app.listen(3000, function() {
  var host, port;
  host = server.address().address;
  port = server.address().port;
  console.log('jeff-project listening at http://%s:%s', host, port);
});