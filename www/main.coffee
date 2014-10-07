"use strict"

Session = require "../common/session"

module.exports = (server) ->

  server.get "/logout", (request, response) ->
    response.logout()
    response.redirect "/"

  server.get "/", (request, response) ->
    Session(request, response, redirect=true).then (error, session) ->
      if error
        response.page "session", page: "session"
      else
        bindings =
          user: session
        response.page "main", bindings

