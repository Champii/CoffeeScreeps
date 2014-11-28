Defender = require 'Defender'

class Archer extends Defender()

  @SetType 'Archer'

  constructor: (@name, @lvl) ->
    @type = 'Archer'

    super()

  Work: ->
    if Memory.target?

      target = @_creep.room.find(Game.HOSTILE_CREEPS,
        filter:
          id: Memory.target
      )[0]

      if @_creep.pos.inRangeTo target, 3
        @Attack target
      else
        @MoveTo target

    else
      @MoveTo @_creep.pos.findNearest Game.MY_SPAWNS


  Attack: (target) ->
    @_creep.rangedAttack target

module.exports = Archer
