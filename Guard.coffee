Defender = require 'Defender'

class Guard extends Defender()

  @SetType 'Guard'

  constructor: (@name, @lvl) ->
    @type = 'Guard'

    super()

  Attack: (target) ->
    @_creep.attack target


module.exports = Guard
