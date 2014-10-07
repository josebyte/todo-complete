"use strict"

__.proxy = (type, method, parameters = {}, background = false) ->
  promise = new Hope.Promise()
  session = __.storage __.SESSION
  token = if session? then session.token else null

  $.ajax
    url         : "#{__.host}/api/#{method}"
    type        : type
    data        : parameters
    dataType    : 'json'
    contentType : "application/x-www-form-urlencoded"
    headers     : "authorization": token
    success: (xhr) ->
      promise.done null, xhr
    error: (xhr, response) =>
      error = code: xhr.status, message: xhr.responseJSON.message
      promise.done error, null
  promise
