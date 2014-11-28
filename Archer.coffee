Defender = require 'Defender'

class Archer extends Defender()

  @SetType 'Archer'

  constructor: (@name, @lvl) ->
    @type = 'Archer'

    super()

  Attack: (target) ->
    @_creep.rangedAttack target

module.exports = Archer
