# firebase-client

[![Build Status](https://travis-ci.org/jpstevens/firebase-client.svg?branch=master)](https://travis-ci.org/jpstevens/firebase-client) [![NPM version](https://badge.fury.io/js/firebase-client.svg)](http://badge.fury.io/js/firebase-client) 

A simple Firebase client for Node.js, based on [oscardelben](https://github.com/oscardelben)'s brilliant [firebase](https://github.com/oscardelben/firebase-ruby) gem.

## Installation:

```
npm install firebase-client
```

Then, in your project require and instantiate the Firebase client:

```javascript
var FirebaseClient = require('firebase-client');
var firebase = new FirebaseClient({
  url: "https://node-firebase-client.firebaseio.com/",
  auth: "my-auth-token"
});
```

## Example Usage:

### GET:

Gets the value of a resource at the specified path.
Returns a promise, resolved on a successful HTTP response, or rejected on a client/server error.

```javascript
firebase.get(path);
```
#### Example:

```javascript
firebase
.get('example')
.then(function(body){
  console.log(body);
})
.fail(function(err){
  console.log(err);
});
```

### SET:

Set the value of a resource at the specified path.
Returns a promise, resolved on a successful HTTP response, or rejected on a client/server error.

```javascript
firebase.set(path, data);
```
#### Example:

```javascript
firebase
.set('example', { value: true })
.then(function(body){
  console.log(body); // returns { value: true }
})
.fail(function(err){
  console.log(err);
});
```

### PUSH:

Creates a new child resource under the specified path.
Returns a promise, resolved on a successful HTTP response, or rejected on a client/server error.

```javascript
firebase.push(path, data);
```
#### Example:

```javascript
firebase
.push('user', { email: 'test@example.com' })
.then(function(body){
  console.log(body); // returns name ref, e.g. { name: "-JR-fhuV6T3vkTNSVrBs" }, of the child resource
})
.fail(function(err){
  console.log(err);
});
```

### UPDATE:

Updates an existing resource at the specified path.
Returns a promise, resolved on a successful HTTP response, or rejected on a client/server error.

```javascript
firebase.update(path, data);
```

#### Example:

```javascript
firebase
.update('example', { value: true })
.then(function(body){
  console.log(body); // returns { value: true }
})
.fail(function(err){
  console.log(err);
});
```

### DELETE:

Removes resource at specified path.
Returns a promise, resolved on a successful HTTP response, or rejected on a client/server error.

```javascript
firebase.delete(path);
```

#### Example:

```javascript
firebase
.delete('example')
.then(function(){
  console.log(); // returns empty body, i.e. null
})
.fail(function(err){
  console.log(err);
});
```

## More info:

For more information, check out the [Firebase API docs](https://www.firebase.com/docs/rest-api.html).

