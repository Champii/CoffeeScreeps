Creep = require('Creep')

class Guard extends Creep()

  @SetType 'guard'

  constructor: (@name, @lvl) ->
    @type = 'guard'

    super()

  Work: ->
    if Memory.target? and
        @_creep.room.find(Game.HOSTILE_CREEPS).length <= Guard.CountCreeps() and
        @_creep.hasBodyParts Game.ATTACK

      target = @_creep.room.find(Game.HOSTILE_CREEPS,
        filter:
          id: Memory.target
      )[0]

      if not @MoveTo target
        @_creep.attack target

    else
      @MoveTo @_creep.pos.findNearest Game.MY_SPAWNS

module.exports = Guard
