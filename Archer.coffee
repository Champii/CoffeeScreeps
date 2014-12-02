Defender = require 'Defender'

class Archer extends Defender()

  @SetType 'Archer'

  Attack: (target) ->
    if (res = @_creep.pos.inRangeTo target, 3)
      super target

  MoveTo: (target) ->
    # TODO: better stay away of enemy
    if @_creep.pos.inRangeTo target, 2
      dir = ((@_creep.pos.getDirectionTo(target) + 3) % 8) + 1
      @_creep.move dir
    else if not @_creep.pos.inRangeTo target, 3
      @_creep.moveTo target

module.exports = Archer
