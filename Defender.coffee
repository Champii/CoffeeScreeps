Creep = require('Creep')

module.exports = ->
  class Defender extends Creep()

    Tick: ->
      if Memory.target?
        if not (target = @DeserializeTarget Memory.target, Game.HOSTILE_CREEPS)
          return @GoHome()

        @MoveTo target
        @Attack target

      else
        @GoHome()

    Attack: (target) ->
      if @_creep.getActiveBodyparts Game.ATTACK
        @_creep.attack target
      if @_creep.getActiveBodyparts Game.RANGED_ATTACK
        @_creep.rangedAttack target

    GoHome: ->
      if Game.flags.Raly?
        @_creep.moveTo Game.flags.Raly
      else
        super()

    @GetGlobalTarget: ->
      target = Game.spawns.Spawn1.pos.findNearest Game.HOSTILE_CREEPS

      if not target?
        Memory.target = null
        return

      Memory.target = target.id
