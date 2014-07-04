request = require "request"

class FirebaseHelper

  @populate: (done) ->
    url = "#{process.env.FIREBASE_URL}/.json?auth=#{process.env.FIREBASE_TOKEN}"
    json = { get: { value: "get" }, delete: "delete" }
    method = "PUT"
    request { method, url, json }, (err, res) ->
      throw err if err
      done()

  @setSecurityRules: (done) ->
    url = "#{process.env.FIREBASE_URL}/.settings/rules.json?auth=#{process.env.FIREBASE_TOKEN}"
    json = { rules: { ".read": false, ".write": false }}
    method = "PUT"
    request { method, url, json }, (err, res) ->
      throw err if err
      done()

module.exports = FirebaseHelper
