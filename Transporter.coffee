Creep = require('Creep')

class Transporter extends Creep()

  @SetType 'Transporter'

  constructor: (@name, @lvl) ->
    @type = 'Transporter'

    super()

  Work: ->

    if @_creep.energy < @_creep.energyCapacity
      source = @_creep.pos.findNearest Game.DROPPED_ENERGY

      if not @_creep.pos.isNearTo source
        @MoveTo source
      else
        @_creep.pickup source
    else
      spawn = @_creep.pos.findNearest Game.MY_SPAWNS
      if not spawn?
        return

      if not @MoveTo spawn
        @_creep.transferEnergy spawn

module.exports = Transporter
