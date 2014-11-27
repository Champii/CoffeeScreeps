class Miner extends Creep

  @::type = 'miner'

  constructor: (@name, @lvl) ->
    @type = 'miner'

    super()

  Work: ->
    source = @_creep.pos.findNearest Game.SOURCES_ACTIVE

    if not @MoveTo source
      @_creep.harvest source
