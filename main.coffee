Spawner = require 'Spawner'
Creep = require('Creep')()
Defender = require('Defender')()

class Main

  constructor: ->
    @InitSpawners()
    @InitLvl()
    @InitTarget()
    @InitCreeps()

  InitLvl: ->

    @lvl = 0

    for k in Game.structures when k.structureType is 'extension'
      @lvl++

  InitTarget: ->
    Defender.GetGlobalTarget()

  InitSpawners: ->
    @spawners = (new Spawner spawn for spawn of Game.spawns)

  InitCreeps: ->
    @creeps = (Creep.Get creep, @lvl for creep of Game.creeps)


main = new Main()
