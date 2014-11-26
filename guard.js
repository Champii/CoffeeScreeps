var utils = require('utils');

module.exports = function (creep)
{
    if (Memory.target
        && Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS).length <= utils.countCreep('g')
        && creep.getActiveBodyparts(Game.ATTACK))
    {
        var target = Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS, {filter: {id: Memory.target}})[0];
        console.log('guard attack: ', target);

        if (target)
        {
            console.log('move', creep.moveTo(target.pos));
            console.log('attack', creep.attack(target));

        }
    }
    else
        creep.moveTo(Game.spawns.Spawn1);

    console.log('guard : ', Memory.target);
}
