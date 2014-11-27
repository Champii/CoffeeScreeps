var Body;

Body = (function() {
  function Body() {
    this.body = [];
    this.nextBody = [];
    Body.GetBody();
  }

  Body.GetBodyCost = function() {
    var bodyCosts, i, res, _i, _len, _ref;
    if (!this.prototype.type) {
      return -1;
    }
    bodyCosts = {};
    bodyCosts[Game.MOVE] = 50;
    bodyCosts[Game.WORK] = 20;
    bodyCosts[Game.CARRY] = 50;
    bodyCosts[Game.ATTACK] = 100;
    bodyCosts[Game.RANGED_ATTACK] = 150;
    bodyCosts[Game.HEAL] = 200;
    bodyCosts[Game.TOUGH] = 5;
    res = 0;
    _ref = Body.GetBody();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      i = _ref[_i];
      res += bodyCosts[i];
    }
    return res;
  };

  Body.GetBody = function(type) {
    var bodies, t;
    t = this.prototype.type;
    if (t == null) {
      t = type;
    }
    bodies = {
      miner: {
        body: [Game.MOVE, Game.WORK, Game.WORK, Game.WORK, Game.WORK],
        next: [Game.WORK]
      },
      transporter: {
        body: [Game.MOVE, Game.MOVE, Game.CARRY, Game.CARRY, Game.CARRY],
        next: [Game.CARRY]
      },
      guard: {
        body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.MOVE, Game.ATTACK],
        next: [Game.ATTACK]
      },
      healer: {
        body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.HEAL, Game.MOVE],
        next: [Game.HEAL]
      }
    };
    console.log('type', t);
    return bodies[t];
  };

  return Body;

})();
var Creep,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Creep = (function(_super) {
  __extends(Creep, _super);

  function Creep() {
    Creep.__super__.constructor.call(this);
    this._creep = Game.creeps[this.name];
    this.Work();
  }

  Creep.prototype.MoveTo = function(target) {
    if (this._creep.pos.isNearTo(target)) {
      return false;
    }
    if (this._creep.moveTo(target < 0)) {
      return false;
    }
    return true;
  };

  Creep.CountCreeps = function(type) {
    var creep, creeps, i, _i, _len;
    creeps = Game.spawns.Spawn1.room.find(Game.MY_CREEPS);
    if (!type) {
      return creeps.length;
    }
    i = 0;
    for (_i = 0, _len = creeps.length; _i < _len; _i++) {
      creep = creeps[_i];
      if (creep.name.slice(0) === type) {
        i++;
      }
    }
    return i;
  };

  Creep.Get = function(name, lvl) {
    if (name.slice(0, -1) === 'miner') {
      return new Miner(name, lvl);
    } else if (name.slice(0, -1) === 'transporter') {
      return new Transporter(name, lvl);
    } else if (name.slice(0, -1) === 'guard') {
      return new Guard(name, lvl);
    } else if (name.slice(0, -1) === 'healer') {
      return new Healer(name, lvl);
    }
  };

  return Creep;

})(Body);
var Guard,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Guard = (function(_super) {
  __extends(Guard, _super);

  Guard.prototype.type = 'guard';

  function Guard(name, lvl) {
    this.name = name;
    this.lvl = lvl;
    this.type = 'guard';
    Guard.__super__.constructor.call(this);
  }

  Guard.prototype.Work = function() {
    var target;
    if ((Memory.target != null) && this._creep.room.find(Game.HOSTILE_CREEPS).length <= Guard.CountCreeps() && this._creep.hasBodyParts(Game.ATTACK)) {
      target = this._creep.room.find(Game.HOSTILE_CREEPS, {
        filter: {
          id: Memory.target
        }
      })[0];
      if (!this.MoveTo(target)) {
        return this._creep.attack(target);
      }
    } else {
      return this.MoveTo(this._creep.pos.findNearest(Game.MY_SPAWNS));
    }
  };

  return Guard;

})(Creep);
var Healer,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Healer = (function(_super) {
  __extends(Healer, _super);

  Healer.prototype.type = 'healer';

  function Healer(name, lvl) {
    this.name = name;
    this.lvl = lvl;
    this.type = 'healer';
    Healer.__super__.constructor.call(this);
  }

  Healer.prototype.Work = function() {};

  return Healer;

})(Creep);
var Miner,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Miner = (function(_super) {
  __extends(Miner, _super);

  Miner.prototype.type = 'miner';

  function Miner(name, lvl) {
    this.name = name;
    this.lvl = lvl;
    this.type = 'miner';
    Miner.__super__.constructor.call(this);
  }

  Miner.prototype.Work = function() {
    var source;
    source = this._creep.pos.findNearest(Game.SOURCES_ACTIVE);
    if (!this.MoveTo(source)) {
      return this._creep.harvest(source);
    }
  };

  return Miner;

})(Creep);
var Spawner;

Spawner = (function() {
  function Spawner(name) {
    var nbG, nbH, nbM, nbT, order;
    this.name = name;
    this._spawn = Game.spawns[this.name];
    if (Memory.miner == null) {
      Memory.miner = 0;
    }
    if (Memory.transporter == null) {
      Memory.transporter = 0;
    }
    if (Memory.guard == null) {
      Memory.guard = 0;
    }
    if (Memory.healer == null) {
      Memory.healer = 0;
    }
    if (Memory.nextCreepIdx == null) {
      Memory.nextCreepIdx = 0;
    }
    nbT = Creep.CountCreeps('transporter');
    nbM = Creep.CountCreeps('miner');
    nbG = Creep.CountCreeps('guard');
    nbH = Creep.CountCreeps('healer');
    order = ['miner', 'transporter', 'guard', 'healer'];
    if (!this._spawn.spawning && this.Spawn(order[Memory.nextCreepIdx])) {
      Memory.nextCreepIdx++;
      if (Memory.nextCreepIdx >= order.length) {
        Memory.nextCreepIdx = 0;
      }
    }
  }

  Spawner.prototype.Spawn = function(type) {
    if (typeof this._spawn.createCreep(Body.GetBody(type).body, type + Memory[type]) === 'string') {
      return Memory[type]++;
    } else {
      return false;
    }
  };

  return Spawner;

})();
var Transporter,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Transporter = (function(_super) {
  __extends(Transporter, _super);

  Transporter.prototype.type = 'transporter';

  function Transporter(name, lvl) {
    this.name = name;
    this.lvl = lvl;
    this.type = 'transporter';
    Transporter.__super__.constructor.call(this);
  }

  Transporter.prototype.Work = function() {
    var source, spawn;
    source = this._creep.pos.findNearest(Game.DROPPED_ENERGY);
    if (this._creep.energy < this._creep.energyCapacity) {
      if (!this._creep.pos.isNearTo(source)) {
        return this._creep.moveTo(source);
      } else {
        return this._creep.pickup(source);
      }
    } else {
      spawn = this._creep.pos.findNearest(Game.MY_SPAWNS);
      return this._cree.moveTo(spawn);
    }
  };

  return Transporter;

})(Creep);
var Main, main;

Main = (function() {
  function Main() {
    this.InitSpawners();
    this.InitLvl();
    this.InitCreeps();
  }

  Main.prototype.InitLvl = function() {
    var k, _i, _len, _ref, _results;
    this.lvl = 0;
    _ref = Game.structures;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      k = _ref[_i];
      if (k.structureType === 'extension') {
        _results.push(this.lvl++);
      }
    }
    return _results;
  };

  Main.prototype.InitSpawners = function() {
    var spawn;
    return this.spawners = (function() {
      var _results;
      _results = [];
      for (spawn in Game.spawns) {
        _results.push(new Spawner(spawn));
      }
      return _results;
    })();
  };

  Main.prototype.InitCreeps = function() {
    var creep;
    return this.creeps = (function() {
      var _results;
      _results = [];
      for (creep in Game.creeps) {
        _results.push(Creep.Get(creep, this.lvl));
      }
      return _results;
    }).call(this);
  };

  return Main;

})();

main = new Main();
