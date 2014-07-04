FirebaseClient = require "../../src/firebase-client"
FirebaseHelper = require "../helpers/firebase-helpers"

describe "Integration with firebaseio.com", ->
  
  @timeout 10000

  before (next) ->
    auth = process.env.FIREBASE_TOKEN
    url = process.env.FIREBASE_URL
    @firebase = new FirebaseClient { url, auth }
    FirebaseHelper.setSecurityRules ->
      FirebaseHelper.populate next

  describe "update", ->

    it "returns true if successful", (done) ->
      @firebase
      .update("/update", { example: 'update' })
      .then (body) ->
        expect(body).to.deep.equal { example: 'update' }
        done()

  describe "get", ->

    it "returns the value if successful", (done) ->
      @firebase
      .get("/get")
      .then (body) ->
        expect(body).to.deep.equal { value: 'get' }
        done()

  describe "set", ->

    it "returns true if successful", (done) ->
      @firebase
      .set("/set", { example: 'set' })
      .then (body) ->
        expect(body).to.deep.equal { example: 'set' }
        done()

  describe "push", ->

    it "returns true if successful", (done) ->
      @firebase
      .push("/push", { example: 'push' })
      .then (body) ->
        expect(body.name).to.be.truthy
        done()

  describe "delete", ->

    it "returns true if successful", (done) ->
      @firebase
      .delete("/delete")
      .then (body) ->
        expect(body).to.equal null
        done()
