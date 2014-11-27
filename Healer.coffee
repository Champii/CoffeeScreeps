Creep = require('Creep')

class Healer extends Creep()

  @SetType 'healer'

  constructor: (@name, @lvl) ->
    @type = 'healer'

    super()

  Work: ->

module.exports = Healer
