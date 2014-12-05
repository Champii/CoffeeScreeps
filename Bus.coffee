class Bus

  listeners: {}

  on: (args...) ->
    if not @listeners[args[0]]?
      @listeners[args[0]] = []

    @listeners[args[0]].push args[1]

  emit: (args...) ->
    for listener in @listeners[args[0]]
      listener.apply listener, args[1..] if listener

module.exports = new Bus
