var utils = require('utils');

module.exports = function (spawn)
{
    if (!Memory.h)
        Memory.h = 0
    if (!Memory.b)
        Memory.b = 0
    if (!Memory.g)
        Memory.g = 0
    if (!Memory.s)
        Memory.s = 0

    var lvl = 0;
    var structs = spawn.room.find(Game.MY_STRUCTURES);
    for (var k in structs)
        if (structs[k].structureType == 'extension')
            lvl++

    var guardBody = utils.getGuardBody(lvl);
    var harvesterBody = utils.getHarvesterBody(lvl);
    var builderBody = utils.getBuilderBody(lvl);
    var healerBody = utils.getHealerBody(lvl);

    var nbG = utils.countCreep('g');
    var nbH = utils.countCreep('h');
    var nbB = utils.countCreep('b');
    var nbS = utils.countCreep('s'); // Healer == "Support"


/*    console.log(nbG, nbH, nbB, nbS);*/
    // console.log(lvl);
    // console.log(guardBody.body);
    // console.log(harvesterBody.body);
    // console.log(builderBody.body);
    // console.log(healerBody.body);

    if (nbS <= nbG / 2 && spawn.energy >= healerBody.cost && typeof(spawn.createCreep(healerBody.body, 's' + Memory.s)) == 'string')
        return Memory.s++;
    if (nbB < 1 && spawn.energy >= builderBody.cost && typeof(spawn.createCreep(builderBody.body, 'b' + Memory.b)) == 'string')
        Memory.b++;
    else if (nbG <= nbH && spawn.energy >= guardBody.cost && typeof(spawn.createCreep(guardBody.body, 'g' + Memory.g)) == 'string')
        Memory.g++;
    else if (nbH < nbG && spawn.energy >= harvesterBody.cost && typeof(spawn.createCreep(harvesterBody.body, 'h' + Memory.h)) == 'string')
        Memory.h++;

};
