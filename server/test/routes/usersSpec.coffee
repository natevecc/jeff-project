request = require 'supertest'
server = require '../../src/server'

describe 'api/users', ->
  describe 'GET /', ->
    it 'returns a list of users in the db', (done) ->
      request(server)
        .get('/api/users')
        .expect(200, [{}], done)