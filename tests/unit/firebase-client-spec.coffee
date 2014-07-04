FirebaseClient = require "../../src/firebase-client"

describe "Firebase Client", ->

  before ->
    @data = { name: "Jack" }
    @firebase = new FirebaseClient { url: "https://test.firebaseio.com" }

  describe "set", ->

    before ->
      @requestSpy = sinon.spy @firebase.request, "put"

    after ->
      @firebase.request.put.restore()

    it "writes and returns the data", ->
      @firebase.set "users/info", @data
      expect(@requestSpy.calledWith 'users/info', @data).to.be.ok

  describe "get", ->

    before ->
      @requestSpy = sinon.spy @firebase.request, "get"

    after ->
      @firebase.request.get.restore()

    it "returns the data", ->
      @firebase.get "users/info"
      expect(@requestSpy.calledWith "users/info").to.be.ok

  describe "push", ->

    before ->
      @requestSpy = sinon.spy @firebase.request, "post"

    after ->
      @firebase.request.post.restore()

    it "writes the data", ->
      @firebase.push "users", @data
      expect(@requestSpy.calledWith 'users', @data).to.be.ok

  describe "delete", ->
    
    before ->
      @requestSpy = sinon.spy @firebase.request, "delete"

    after ->
      @firebase.request.delete.restore()

    it "returns true", ->
      @firebase.delete "users/info"
      expect(@requestSpy.calledWith "users/info").to.be.ok

  describe "update", ->
    
    before ->
      @requestSpy = sinon.spy @firebase.request, "patch"

    after ->
      @firebase.request.patch.restore()

    it "updates and returns the data", ->
      @firebase.update "users/info", @data
      expect(@requestSpy.calledWith "users/info", @data).to.be.ok
