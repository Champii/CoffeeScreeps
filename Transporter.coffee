Creep = require('Creep')

class Transporter extends Creep()

  @SetType 'transporter'

  constructor: (@name, @lvl) ->
    @type = 'transporter'

    super()

  Work: ->
    source = @_creep.pos.findNearest Game.DROPPED_ENERGY

    if @_creep.energy < @_creep.energyCapacity
      if not @_creep.pos.isNearTo source
        @_creep.moveTo source
      else
        @_creep.pickup source
    else
      spawn = @_creep.pos.findNearest Game.MY_SPAWNS
      @_cree.moveTo spawn

module.exports = Transporter
