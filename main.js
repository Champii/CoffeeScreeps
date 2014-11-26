var harvester = require('harvester');
var builder = require('builder');
var guard = require('guard');
var spawn = require('spawn');
var roles = require('roles');
var healer = require('healer');
var hostileTarget = require('hostileTarget')

// Assign roles
roles();

// Find global target
hostileTarget();

// Spawn creeps
if (!Game.spawns.Spawn1.spawning)
  spawn(Game.spawns.Spawn1);

// Apply role
for (var name in Game.creeps)
{
  var creep = Game.creeps[name];

  if (creep.memory.role == 'harvester')
    harvester(creep);
  if(creep.memory.role == 'builder')
    builder(creep);
  if (creep.memory.role == 'guard')
    guard(creep);
  if (creep.memory.role == 'healer')
    healer(creep);
}
