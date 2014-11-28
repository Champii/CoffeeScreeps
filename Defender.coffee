Creep = require('Creep')

module.exports = ->
  class Defender extends Creep()

    Work: ->
      if Memory.target?

        target = @_creep.room.find(Game.HOSTILE_CREEPS,
          filter:
            id: Memory.target
        )[0]

        if not @MoveTo target
          @Attack target

      else
        @MoveTo @_creep.pos.findNearest Game.MY_SPAWNS

    @GetGlobalTarget: ->
      target = Game.spawns.Spawn1.pos.findNearest Game.HOSTILE_CREEPS

      if not target?
        Memory.target = null
        return

      Memory.target = target.id
