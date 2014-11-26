var harvester = require('harvester');
var utils = require('utils');

module.exports = function (creep)
{
    var nb = utils.countCreep();

    if (creep.energy == 0 || nb < 10)
      harvester(creep);
    else if (creep.energy && nb >= 10)
    {
      var targets = creep.room.find(Game.CONSTRUCTION_SITES);
      if(targets.length)
      {
        creep.moveTo(targets[0]);
        creep.build(targets[0]);
      }
    }
};
