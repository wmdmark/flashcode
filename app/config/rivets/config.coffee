rivets.adapters[":"] =
  observe: (obj, keypath, callback) ->
    obj.on "change:" + keypath, callback
    return

  unobserve: (obj, keypath, callback) ->
    obj.off "change:" + keypath, callback
    return

  get: (obj, keypath) ->
    obj.get keypath

  set: (obj, keypath, value) ->
    obj.set keypath, value
    return
    
rivets.formatters.negate = (value)-> !value