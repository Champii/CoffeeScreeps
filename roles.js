/*
 *  Assign roles thanks to creep name
 */

var giveRole = function (creep)
{
  if (creep.name[0] == 'h')
    creep.memory.role = 'harvester'
  else if (creep.name[0] == 'b')
    creep.memory.role = 'builder'
  else if (creep.name[0] == 'g')
    creep.memory.role = 'guard'
  else if (creep.name[0] == 's')
    creep.memory.role = 'healer'
};

module.exports = function ()
{
  var list = Game.spawns.Spawn1.room.find(Game.MY_CREEPS);

  // For each creeps, assign role if none
  for (var name in list)
  {
    var creep = list[name];

    if (!creep.memory.role)
      giveRole(creep);
  }
};
