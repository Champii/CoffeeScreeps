Creep = require('Creep')

Memory.energyTarget? || Memory.energyTarget = null

class Transporter extends Creep()

  @SetType 'Transporter'

  Tick: ->
    if @_creep.energy < @_creep.energyCapacity
      if not Memory.energyTarget?
        if not @FindEnergy()
          return @GoHome()

      if not (target = @DeserializeTarget Memory.energyTarget, Game.DROPPED_ENERGY)
        Memory.energyTarget = null
        return @GoHome()

      @MoveTo target
      @Work target
    else
      @GoHome()

  FindEnergy: ->
    targets = Game.spawns.Spawn1.pos.findInRange Game.DROPPED_ENERGY, 8

    if not targets.length
      return Memory.energyTarget = null

    target = {energy: 0}
    for t in targets
      if t.energy > target.energy
        target = t

    if target?
      Memory.energyTarget = target.id
    else
      Memory.energyTarget = null

  GoHome: ->
    @_creep.transferEnergy super()

module.exports = Transporter
