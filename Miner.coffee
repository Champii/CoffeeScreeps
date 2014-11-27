class Miner extends Creep

  @SetType 'miner'

  constructor: (@name, @lvl) ->
    @type = 'miner'

    super()

  Work: ->
    source = @_creep.pos.findNearest Game.SOURCES_ACTIVE

    if not @MoveTo source
      @_creep.harvest source

module.exports = Miner
Creep = require('Creep')()
