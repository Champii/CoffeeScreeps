class Healer extends Creep

  @::type = 'healer'

  constructor: (@name, @lvl) ->
    @type = 'healer'

    super()

  Work: ->
