class Creep extends Body

  constructor: ->
    super()

    @_creep = Game.creeps[@name]

    @Work()

  MoveTo: (target) ->
    if @_creep.pos.isNearTo target
      return false
    if @_creep.moveTo target < 0
      return false

    true


  @CountCreeps: (type) ->
    creeps = Game.spawns.Spawn1.room.find Game.MY_CREEPS

    if not type
      return creeps.length

    i = 0
    for creep in creeps when creep.name[..-1] is type
      i++

    i

  @Get: (name, lvl) ->
    if name[..-2] is 'miner'
      new Miner name, lvl
    else if name[..-2] is 'transporter'
      new Transporter name, lvl
    else if name[..-2] is 'guard'
      new Guard name, lvl
    else if name[..-2] is 'healer'
      new Healer name, lvl
