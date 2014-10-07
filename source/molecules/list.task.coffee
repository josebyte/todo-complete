"use strict"

class Atoms.Molecule.ListTask extends Atoms.Molecule.List

  @template : """<ul id="todo-list" {{#if.style}}class="{{style}}"{{/if.style}}></ul>"""

  @extends: true

  @default:
    id: "list"
    bind:
      atom      : "Atom.LiTask"
      entity    : "__.Entity.Task"
      create    : true
      update    : true

  constructor: ->
    super
    __.proxy("GET", "task").then (error, result) =>
        unless error
          __.Entity.Task.create task for task in result
