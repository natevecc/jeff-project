request = require 'supertest-as-promised'
expect = require('chai').expect
server = require '../../src/server'
models = require '../../src/models'

describe 'api/users', ->

  users = [
    email: 'test1@test.com'
    password: 'hash1'
  ]

  afterEach ->
    models.user.destroy
      truncate: true
      force: true

  describe 'GET /', ->
    
    beforeEach ->
      models.user.bulkCreate users

    it 'returns a list of users in the db', ->
      request(server)
        .get('/api/users')
        .expect (req) ->
          expect(req.body.length).to.equal(1)
        .expect(200)
        .toPromise()
  
  describe 'POST /', ->
    it "creates a user and hash it's password", () ->
      request(server)
      .post('/api/users')
      .send
        email: 'create1@test.com'
        password: 'testPassword1234'
      .expect(201)
      .then (req) ->
        createdUser = req.body
        expect(createdUser).to.have.property('email', 'create1@test.com')
        expect(createdUser).to.not.have.property('password')
        models.user.findById(createdUser.id)
      .then (createdUserDB) ->
        expect(createdUserDB).to.have.property('password').with.length(60)

