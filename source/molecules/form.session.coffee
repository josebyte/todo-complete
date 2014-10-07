"use strict"

class Atoms.Molecule.FormSession extends Atoms.Molecule.Form

  @default:
    children: [
      "Atom.Input": placeholder: "mail", name: "mail", type: "text"
    ,
      "Atom.Input": placeholder: "password", name: "password", type: "password"
    ,
      "Atom.Button": text: "Login", events: ["touch"], callbacks: ["onLogin"]
    ]

  onLogin: ->
    __.proxy("POST", "login", @value()).then (error, result) ->
      unless error
        __.storage __.SESSION, result
        document.cookie = "todo=#{result.token}"
        window.location.reload()
