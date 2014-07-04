FirebaseRequest = require "../../src/firebase-request"
q = require "q"

describe "Firebase Request", ->

  describe "url builder", ->

    before ->
      @req = new FirebaseRequest { url: "https://test.firebaseio.com" }

    describe "without auth", ->

      it "builds the correct url when passed no path", ->
        expect(@req.buildUrl()).to.equal "https://test.firebaseio.com/.json"

      it "builds the correct url when passed a path", ->
        expect(@req.buildUrl('users/jack')).to.equal "https://test.firebaseio.com/users/jack.json"

    describe "with auth", ->

      before ->
        @req = new FirebaseRequest { url: "https://test.firebaseio.com", auth: "token" }

      it "builds the correct url when passed no path", ->
          expect(@req.buildUrl()).to.equal "https://test.firebaseio.com/.json?auth=token"

        it "builds the correct url when passed a path", ->
          expect(@req.buildUrl('users/jack')).to.equal "https://test.firebaseio.com/users/jack.json?auth=token"

    describe "with query params", ->

      before ->
        @req = new FirebaseRequest { url: "https://test.firebaseio.com" }

      it "builds the correct url when passed no path", ->
          expect(@req.buildUrl "/", { a: "apple" }).to.equal "https://test.firebaseio.com/.json?a=apple"

        it "builds the correct url when passed a path", ->
          expect(@req.buildUrl('users/jack', { a: "apple" })).to.equal "https://test.firebaseio.com/users/jack.json?a=apple"


  describe "handle response", ->
    
    beforeEach ->
      req = new FirebaseRequest { url: "https://test.firebaseio.com" }
      @deferred = q.defer()
      @handler = req.handleResponse @deferred

    it "passes if there is a successful response", (done) ->
      res = { statusCode: 200, body: true }
      @deferred.promise.then (body) ->
        expect(body).to.be.ok
        done()
      @handler(res)

    it "passes the body of the response if successful", (done) ->
      res = { statusCode: 200, body: "example" }
      @deferred.promise.then (body) ->
        expect(body).to.equal "example"
        done()
      @handler(res)

    it "fails if there is a server error in the response", ->
      res = { statusCode: 500, body: "example" }
      @deferred.promise.fail (err) ->
        expect(err).to.be.typeof Error
        done()
      @handler(res)

    it "fails if there is a client error in the response", ->
      res = { statusCode: 400, body: "example" }
      @deferred.promise.fail (err) ->
        expect(err).to.be.typeof Error
        done()
      @handler(res)

  describe "making a", ->

    before ->
      @req = new FirebaseRequest { url: "https://test.firebaseio.com" }
      @expectedUrl = "https://test.firebaseio.com/example.json?q=abc"

    beforeEach ->
      @requestSpy = sinon.spy(@req, "request")

    afterEach ->
      @req.request.restore()

    describe "get request", ->

      it "performs the correct request", ->
        @req.get "/example", { q: "abc" }
        expect(@requestSpy.args[0][0]).to.deep.equal { method: "GET", json: true, url: @expectedUrl }

      it "returns a promise"

    describe "put request", ->

      it "performs the correct request", ->
        @req.put "/example", { data: true }, { q: "abc" }
        expect(@requestSpy.args[0][0]).to.deep.equal { method: "PUT", json: { data: true }, url: @expectedUrl }

      it "returns a promise"

    describe "post request", ->

      it "performs the correct request", ->
        @req.post "/example", { data: true }, { q: "abc" }
        expect(@requestSpy.args[0][0]).to.deep.equal { method: "POST", json: { data: true }, url: @expectedUrl }

      it "returns a promise"

    describe "patch request", ->

      it "performs the correct request", ->
        @req.patch "/example", { data: true }, { q: "abc" }
        expect(@requestSpy.args[0][0]).to.deep.equal { method: "PATCH", json: { data: true }, url: @expectedUrl }

      it "returns a promise"

    describe "delete request", ->

      it "performs the correct request", ->
        @req.delete "/example", { q: "abc" }
        expect(@requestSpy.args[0][0]).to.deep.equal { method: "DELETE", json: true, url: @expectedUrl }

      it "returns a promise"


