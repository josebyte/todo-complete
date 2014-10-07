"use strict"

class Atoms.Organism.Footer extends Atoms.Molecule.Div

  @template: """
    <footer id="footer">
      <span id="todo-count"><strong>{{active.toString()}}</strong> item left</span>
      <div>
         <ul id="filters">
                    <li>
                        <a href="#/">All</a>
                    </li>
                    <li>
                        <a href="#/active">Active</a>
                    </li>
                    <li>
                        <a href="#/completed">Completed</a>
                    </li>
                </ul>
          <button id="clear-completed">Clear completed (<strong>{{completed.toString()}}</strong>)</button>
        </div>
    </footer>"""

  @default  :
    active: 0
    completed: 0

  constructor: ->
    super
    __.Entity.Task.bind "create", @reload
    __.Entity.Task.bind "update", @reload
    __.Entity.Task.bind "destroy", @onTaskDestroy
    do @reload

  onTaskDestroy: =>
    do @reload
    do @showTasks

  _render: ->
    super
    @filters = @el.find("a")
    @filters.bind("touch", @onFilter)
    @filters.first().addClass("selected")
    @el.find("button").bind "touch", @onClear

  reload: =>
    @attributes.active = __.Entity.Task.active().length
    @attributes.completed = __.Entity.Task.completed().length
    do @refresh

  onFilter: (event) =>
    el = Atoms.$ event.currentTarget
    el.addClass("selected").siblings("a").removeClass("selected")
    @showTasks el.attr("href").replace("#/", "") or "all"

  onClear: =>
    task.destroy() for task in __.Entity.Task.completed()
    do @reload
    do @showTasks

  showTasks: (@filter = "all")=>
    __.tasks.entity __.Entity.Task[@filter]()
