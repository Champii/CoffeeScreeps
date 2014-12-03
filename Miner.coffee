_ = require 'lodash'

Creep = require 'Creep'

class Miner extends Creep()

  constructor: (@name, @lvl) ->
    super()

    @_creep.memory.sourceId? || @_creep.memory.sourceId = 0

  Tick: ->
    if @FindSource()
      @MoveTo @source
      @Work @source

  FindSource: ->
    if @_creep.memory.sourceId
      @source = Game.getObjectById @_creep.memory.sourceId
    else
      @source = Game.spawns.Spawn1.pos.findNearest Game.SOURCES_ACTIVE,
        filter: (item) ->
          item.id not in _.chain Game.creeps
                  .filter (creep) -> creep.memory.sourceId?
                  .map (creep) -> creep.memory.sourceId
                  .value()

    if @source?
      @_creep.memory.sourceId = @source.id
    else
      @_creep.memory.sourceId = 0

Miner.Init()

module.exports = Miner
