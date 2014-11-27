module.exports = ->
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
      type = name[0]
      if type is 'm'
        Miner = require('Miner')
        new Miner name, lvl
      else if type is 't'
        Transporter = require('Transporter')
        new Transporter name, lvl
      else if type is 'g'
        Guard = require('Guard')
        new Guard name, lvl
      else if type is 'h'
        Healer = require('Guard')
        new Healer name, lvl


Body = require('Body')()
