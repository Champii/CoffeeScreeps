_ = require 'lodash'

Creep = require 'Creep'

class Engineer extends Creep()

  constructor: (@name, @lvl) ->
    super()
    @_creep.memory.siteId? || @_creep.memory.siteId = 0
    @_creep.memory.engineerState? || @_creep.memory.engineerState = 'pickup'

  Tick: ->
    @FindSource()
    if @_creep.memory.engineerState in ['pickup', 'harvest'] and @_creep.energy <= @_creep.energyCapacity
      @MoveTo @source
      @Work @source
      if @_creep.energy is @_creep.energyCapacity
        @_creep.memory.engineerState = 'build'
    else if @_creep.memory.engineerState is 'build'
      @MoveTo @site
      @Work @site
      if not @_creep.energy
        @_creep.memory.engineerState = 'pickup'

  Work: (target) ->
    if @_creep.getActiveBodyparts(Game.WORK)
      @_creep[@_creep.memory.engineerState] target

  FindSource: ->
    if @_creep.memory.siteId
      @site = Game.getObjectById @_creep.memory.siteId
    else
      nbBySite = ~~(Engineer.CountCreeps() / @_creep.room.find(Game.CONSTRUCTION_SITES).length) + 1
      # console.log nbBySite
      @site = Game.spawns.Spawn1.pos.findNearest Game.CONSTRUCTION_SITES,
        filter: (item) ->
          (_.filter Game.creeps, (creep) ->
            creep.memory.siteId? and creep.memory.siteId is item.id).length < nbBySite


    if @site?
      @_creep.memory.siteId = @site.id
      @source = @site.pos.findNearest Game.DROPPED_ENERGY
      if not @source?
        @source = @site.pos.findNearest Game.SOURCES_ACTIVE
        @_creep.memory.engineerState = 'harvest'
      # console.log @source
    else
      @_creep.memory.siteId = 0

Engineer.Init()

module.exports = Engineer
