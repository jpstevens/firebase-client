class FirebaseClient

  FirebaseRequest = require "./firebase-request"
  FirebaseResponse = require "./firebase-response"

  constructor: (config) ->
    if typeof config.url isnt "string"
      throw new Error "url must be defined"
    config.url = @formatUrl config.url
    @request = new FirebaseRequest config, FirebaseResponse

  set: (path, data = {}, query = {}) ->
    @request.put path, data

  get: (path, query = {}) ->
    @request.get path, query

  push: (path, data = {}, query = {}) ->
    @request.post path, data, query

  delete: (path, query = {}) ->
    @request.delete path, query

  update: (path, data) ->
    @request.patch path, data

  formatUrl: (url = "") ->
    url = "#{url}/" if url[url.length-1] isnt "/"
    url

module.exports = FirebaseClient
