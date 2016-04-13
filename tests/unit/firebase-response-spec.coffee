FirebaseResponse = require "../../src/firebase-response"

describe.only "Firebase Response", ->

  describe "success", ->

    describe "with status code 200", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 200 }

      it "returns true", ->
        expect(@res.success()).to.equal true

    describe "with status code 201", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 201 }

      it "returns true", ->
        expect(@res.success()).to.equal true

    describe "with status code 400", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 400 }

      it "returns false", ->
        expect(@res.success()).to.equal false

    describe "with status code 500", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 500 }

      it "returns false", ->
        expect(@res.success()).to.equal false

  describe "clientError", ->

    describe "with status code 400", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 400 }

      it "returns an error", ->
        expect(@res.clientError()).to.be.error

    describe "with status code 401", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 401 }

      it "returns an error", ->
        expect(@res.clientError()).to.be.error

    describe "with status code 200", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 200 }

      it "returns a falsy value", ->
        expect(@res.clientError()).to.be.falsy

    describe "with status code 500", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 500 }

      it "returns a falsy value", ->
        expect(@res.clientError()).to.be.falsy

  describe "serverError", ->

    describe "with status code 500", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 500 }

      it "returns an error", ->
        expect(@res.serverError()).to.be.error

    describe "with status code 501", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 501 }

      it "returns an error", ->
        expect(@res.serverError()).to.be.error

    describe "with status code 200", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 200 }

      it "returns a falsy value", ->
        expect(@res.serverError()).to.be.falsy

    describe "with status code 400", ->

      before ->
        @res = new FirebaseResponse { body: "BODY", statusCode: 400 }

      it "returns a falsy value", ->
        expect(@res.serverError()).to.be.falsy
