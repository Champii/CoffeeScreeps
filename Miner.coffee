Creep = require('Creep')

class Miner extends Creep()

  @SetType 'Miner'

  Tick: ->
    target = Game.spawns.Spawn1.pos.findNearest(Game.SOURCES)
    if not target.energy
      target = Game.flags.Alternative || Game.spawns.Spawn1.pos.findNearest Game.SOURCES_ACTIVE

    @MoveTo target
    @Work target

module.exports = Miner
