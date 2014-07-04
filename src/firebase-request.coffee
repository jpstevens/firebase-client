q = require "q"
qs = require "querystring"
urlHelper = require "url"
FirebaseResponse = require "./firebase-response"

class FirebaseRequest

  constructor: (config = {}) ->
    @url = config.url
    @auth = config.auth
    @request = require "request"

  get: (path, query = {}) ->
    @process "GET", path, null, query

  put: (path, value = {}, query = {}) ->
    @process "PUT", path, value, query

  post: (path, value = {}, query = {}) ->
    @process "POST", path, value, query

  delete: (path, query = {}) ->
    @process "DELETE", path, null, query

  patch: (path, value = {}, query = {}) ->
    @process "PATCH", path, value, query

  buildUrl: (path = "", query = {}) ->
    path = "#{path}.json"
    query.auth = @auth if @auth
    url = urlHelper.resolve(@url, path)
    url += ("?" + qs.stringify query) if Object.keys(query).length
    url

  process: (method, path, data, query = {}) =>
    opts = { method }
    if data then opts.json = data else opts.json = true
    opts.url = @buildUrl path, query
    deferred = q.defer()
    @request opts, (err, res) =>
      return deferred.reject err if err
      @handleResponse(deferred)(res)
    deferred.promise

  handleResponse: (deferred) ->
    (res) ->
      response = new FirebaseResponse res
      return deferred.resolve response.body if response.success()
      return deferred.reject response.clientError() if response.clientError()
      return deferred.reject response.serverError() if response.serverError()
      null

module.exports = FirebaseRequest
