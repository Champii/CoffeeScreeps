Creep = require('Creep')

class Miner extends Creep()

  @SetType 'Miner'

  constructor: (@name, @lvl) ->
    @type = 'Miner'

    super()

  Work: ->
    source = Game.spawns.Spawn1.pos.findNearest Game.SOURCES_ACTIVE

    if not @MoveTo source
      @_creep.harvest source

module.exports = Miner
