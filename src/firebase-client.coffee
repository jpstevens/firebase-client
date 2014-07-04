Firebase = require "firebase"
q = require "q"

class FirebaseClient

  constructor: (config) ->
    @events = ['value', 'child_added', 'child_changed', 'child_moved', 'child_removed']
    @appName = config.appName
    @secretKey = config.secretKey
    @firebaseUrl = "https://#{@appName}.firebaseio.com"
    @ref = new Firebase @firebaseUrl

  authorize: ->
    deferred = q.defer()
    @ref.auth @secretKey, (err, res) ->
      if err
        deferred.reject err
      else
        deferred.resolve res
    deferred.promise

  unauthorize: ->
    @ref.unauth()

  resource: (resourcePath) ->
    resource = @ref
    (resource = resource.child res) for res in resourcePath.split "."
    resource

  setValue: (resourcePath, value) ->
    deferred = q.defer()
    @resource(resourcePath)
    .set value
    , (err) ->
      if err
        deferred.reject err
      else
        deferred.resolve value
    deferred.promise

  getValue: (resourcePath) ->
    deferred = q.defer()
    @resource(resourcePath)
    .once 'value'
    , (snapshot) ->
      deferred.resolve snapshot.val()
    , (err) ->
      deferred.reject err
    deferred.promise

  on: (event, resourcePath = "") =>
    deferred = q.defer()
    if @events.indexOf(event) < 0
      err = new Error "Invalid event: #{event}"
      deferred.reject err
    @resource(resourcePath)
    .on event
    , (snapshot) ->
      deferred.resolve snapshot.val()
    , (err) ->
      deferred.reject err
    deferred.promise

  onValue: (resourcePath) => @on resourcePath, value
  onChildAdded: (resourcePath) => @on resourcePath, "child_added"
  onChildChanged: (resourcePath) => @on resourcePath, "child_changed"
  onChildRemoved: (resourcePath) => @on resourcePath, "child_removed"
  onChildMoved: (resourcePath) => @on resourcePath, "child_moved"
