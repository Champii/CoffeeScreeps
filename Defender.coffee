Creep = require('Creep')

module.exports = ->
  class Defender extends Creep()

    Tick: ->
      @_creep.memory.targetId? || @_creep.memory.targetId = 0

      if @_creep.hits < @_creep.hitsMax and not @_creep.memory.targetId
        @GetTarget()

      if @_creep.memory.targetId or Memory.target
        if not (@target = Game.getObjectById(@_creep.memory.targetId || Memory.target))
          @_creep.memory.targetId = null
          return @GoHome()

        @MoveTo @target
        @Attack @target

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

    GetTarget: ->
      @target = @_creep.memory.targetId = @_creep.pos.findNearest(Game.HOSTILE_CREEPS)?.id

    @GetGlobalTarget: ->
      Memory.target = Game.spawns.Spawn1.pos.findNearest(Game.HOSTILE_CREEPS)?.id
