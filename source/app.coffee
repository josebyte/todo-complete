"use strict"

Atoms.$ ->
  console.log "------------------------------------------------------------"
  console.log "Atoms v#{Atoms.version} (Atoms.App v#{Atoms.App.version})"
  console.log "------------------------------------------------------------"

  Atoms.$("#new-todo").remove()
  Atoms.$("#todo-list").remove()
  Atoms.$("#footer").remove("")

  container = Atoms.$ "body"
  page = container.attr "data-page"

  if page is "session"
    new Atoms.Molecule.FormSession container: "section#session"
  else
    new Atoms.Atom.InputTask container: "header"
    __.tasks = new Atoms.Molecule.ListTask container: "#main"
    new Atoms.Organism.Footer container: "#todoapp"
    new Atoms.Atom.ButtonLogout container: "#info"
