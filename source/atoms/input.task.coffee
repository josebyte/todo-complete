"use strict"

class Atoms.Atom.InputTask extends Atoms.Atom.Input

  @template : """
    <input id="new-todo" type="text" placeholder="What needs to be done?" value="{{title}}" data-atom-input/>
    """

  @extend: true

  constructor: ->
    super
    @el.on "keyup", @onChange

  onChange: (event, atom) =>
    if event.keyCode is 13 and @value()
      __.proxy("POST", "task", text: @value()).then (error, result) =>
        unless error
          __.Entity.Task.create result
          do @clean
