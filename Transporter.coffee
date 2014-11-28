Creep = require('Creep')

class Transporter extends Creep()

  @SetType 'Transporter'

  constructor: (@name, @lvl) ->
    @type = 'Transporter'

    super()

  Work: ->

    if @_creep.energy < @_creep.energyCapacity
      sources = @_creep.room.find Game.DROPPED_ENERGY
      target = sources[0]
      for source in sources
        if source.energy > target.energy
          target = source

      # source = @_creep.pos.findNearest Game.DROPPED_ENERGY

      if not @_creep.pos.isNearTo target
        @MoveTo target
      else
        @_creep.pickup target
    else
      spawn = @_creep.pos.findNearest Game.MY_SPAWNS
      if not spawn?
        return

      if not @MoveTo spawn
        @_creep.transferEnergy spawn

module.exports = Transporter
