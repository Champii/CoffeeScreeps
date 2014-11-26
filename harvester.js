/*
 *  This module describe the harvesters behaviour
 */

module.exports = function (creep)
{
  // If not full of energy, harvest
  if (creep.energy < creep.energyCapacity)
  {
    var source = creep.pos.findNearest(Game.SOURCES_ACTIVE)

    creep.moveTo(source);
    creep.harvest(source);
  }
  // Else, go to spawn to deliver energy
  else
  {
    var spawn = creep.pos.findNearest(Game.MY_SPAWNS)

    creep.moveTo(spawn);
    creep.transferEnergy(spawn);
  }
}
