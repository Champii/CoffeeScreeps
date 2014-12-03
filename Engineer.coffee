Creep = require 'Creep'

class Engineer extends Creep()

  constructor: (@name, @lvl) ->
    super()
    @_creep.memory.engineerState? || @_creep.memory.engineerState = 'harvest'

  Tick: ->
    @FindSource()
    if @_creep.memory.engineerState is 'harvest' and @_creep.energy <= @_creep.energyCapacity
      @MoveTo @source
      @Work @source
      if @_creep.energy is @_creep.energyCapacity
        @_creep.memory.engineerState = 'build'
    else if @_creep.memory.engineerState is 'build'
      @MoveTo @site
      @Work @site
      if not @_creep.energy
        @_creep.memory.engineerState = 'harvest'

  Work: (target) ->
    if @_creep.getActiveBodyparts(Game.WORK)
      @_creep.build target
      @_creep.harvest target

  FindSource: ->
    @site = Game.spawns.Spawn1.pos.findNearest Game.CONSTRUCTION_SITES
    console.log @site

    if @site?
      @source = @site.pos.findNearest Game.SOURCES_ACTIVE
      console.log @source

Engineer.Init()

module.exports = Engineer
