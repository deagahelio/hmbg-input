local Action
do
  local _class_0
  local _base_0 = {
    bind = function(self, key)
      return table.insert(self.bound, key)
    end,
    update = function(self, dt)
      self.pressed = false
      self.released = false
      local _list_0 = self.bound
      for _index_0 = 1, #_list_0 do
        local key = _list_0[_index_0]
        if love.keyboard.isDown(key) then
          if not self.pressed and not self.down then
            self.pressed = true
          end
          self.down = true
          self.heldFor = self.heldFor + dt
          return 
        end
      end
      if not self.released and self.down then
        self.released = true
      end
      self.down = false
      self.heldFor = 0
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, name)
      self.name = name
      self.bound = { }
      self.down = false
      self.pressed = false
      self.released = false
      self.heldFor = 0
    end,
    __base = _base_0,
    __name = "Action"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Action = _class_0
end
local Input
do
  local _class_0
  local _base_0 = {
    bind = function(self, key, action)
      if not self.actions[action] then
        self.actions[action] = Action(action)
      end
      return self.actions[action]:bind(key)
    end,
    pressed = function(self, action)
      return self.actions[action].pressed
    end,
    released = function(self, action)
      return self.actions[action].released
    end,
    down = function(self, action)
      return self.actions[action].down
    end,
    heldFor = function(self, action)
      return self.actions[action].heldFor
    end,
    hasHeld = function(self, action, duration)
      return self.actions[action].heldFor >= duration
    end,
    update = function(self, dt)
      for _, action in pairs(self.actions) do
        action:update(dt)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.actions = { }
    end,
    __base = _base_0,
    __name = "Input"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Input = _class_0
end
return Input
