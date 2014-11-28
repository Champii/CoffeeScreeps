Defender = require 'Defender'

class Archer extends Defender()

  @SetType 'Archer'

  Attack: (target) ->
    if @_creep.pos.inRangeTo target, 3
      super()

  MoveTo: (target) ->
    if not @_creep.pos.inRangeTo target, 3
      @_creep.moveTo target

module.exports = Archer
