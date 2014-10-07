"use strict"

class Atoms.Atom.LiTask extends Atoms.Atom.Li

  @template: """
    <li class="{{#done}}completed{{/done}}">
        <div class="view">
            <input class="toggle" type="checkbox" {{#done}}checked{{/done}} />
            <label>{{text}}</label>
            <button class="destroy"></button>
        </div>
        <input class="edit" value="{{text}}" />
    </li>"""

  _render: ->
    super
    @el.find("button").bind "touch", @onDestroy
    @el.find(".toggle").bind "touch", @onDone
    @el.find("div").bind "doubleTap", @onEditing

  onEditing: =>
    @el.addClass "editing"
    @input = @el.find ".edit"
    @input.on "keyup", @onChange

  onChange: (event) =>
    if event.keyCode is 13 and @input.val()
      attributes =
        id   : @entity.id
        text : @input.val()

      @_onUpdate attributes

  onDestroy: =>
    __.proxy("DELETE", "task", id: @entity.id).then (error, result) =>
      unless error
        @entity.destroy()

  onDone: =>
    @attributes.done = !@entity.done
    attributes =
      id   : @entity.id
      done : @attributes.done
    @_onUpdate attributes

  _onUpdate: (attributes) ->
    __.proxy("PUT", "task", attributes).then (error, result) =>
      unless error
        @entity.updateAttributes result

