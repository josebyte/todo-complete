"use strict"

class Atoms.Atom.ButtonLogout extends Atoms.Atom.Button

  @template : """
    <button name="logout" data-atom-button>Logout</button>
    """
  @extend: true

  constructor: ->
    super
    @el.on "touch", @onLogout

  onLogout: (event, atom) =>
    window.location.href = "/logout"
