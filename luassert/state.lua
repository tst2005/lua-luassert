local _M, crequire, brequire = require("newmodule")(...)

-- maintains a state of the assert engine in a linked-list fashion
-- records; formatters, parameters, spies and stubs

local state_mt = {
      __call = function(self)
        self:revert()
      end }

local nilvalue = {} -- unique ID to refer to nil values for parameters

-- will hold the current state
local current

-- exported module table
local state = _M

------------------------------------------------------
-- Reverts to a (specific) snapshot.
-- @param self (optional) the snapshot to revert to. If not provided, it will revert to the last snapshot.
state.revert = function(self)
  if not self then
    -- no snapshot given, so move 1 up
    self = current
    if not self.previous then
      -- top of list, no previous one, nothing to do
      return
    end
  end
  if getmetatable(self) ~= state_mt then error("Value provided is not a valid snapshot", 2) end
  
  if self.next then
    self.next:revert()
  end
  -- revert formatters in 'last'
  self.formatters = {}
  -- revert parameters in 'last'
  self.parameters = {}
  -- revert spies/stubs in 'last'
  while self.spies[1] do
    self.spies[1]:revert()
    table.remove(self.spies, 1)
  end
  setmetatable(self, nil) -- invalidate as a snapshot
  current = self.previous
  current.next = nil
end

------------------------------------------------------
-- Creates a new snapshot.
-- @return snapshot table
state.snapshot = function()
  local s = current
  local new = setmetatable ({
    formatters = {},
    parameters = {},
    spies = {},
    previous = current,
    revert = state.revert,
  }, state_mt)
  if current then current.next = new end
  current = new
  return current
end


--  FORMATTERS
state.add_formatter = function(callback)
  table.insert(current.formatters, 1, callback)
end

state.remove_formatter = function(callback, s)
  s = s or current
  for i, v in ipairs(s.formatters) do
    if v == callback then
      table.remove(s.formatters, i)
      break
    end
  end
  -- wasn't found, so traverse up 1 state
  if s.previous then
    state.remove_formatter(callback, s.previous)
  end
end

state.format_argument = function(val, s)
  s = s or current
  for _, fmt in ipairs(s.formatters) do
    local valfmt = fmt(val)
    if valfmt ~= nil then return valfmt end
  end
  -- nothing found, check snapshot 1 up in list
  if s.previous then
    return state.format_argument(val, s.previous)
  end
  return nil -- end of list, couldn't format
end


--  PARAMETERS
state.set_parameter = function(name, value)
  if value == nil then value = nilvalue end
  current.parameters[name] = value
end

state.get_parameter = function(name, s)
  s = s or current
  local val = s.parameters[name]
  if val == nil and s.previous then
    -- not found, so check 1 up in list
    return state.get_parameter(name, s.previous)
  end
  if val ~= nilvalue then
    return val
  end
  return nil
end

--  SPIES / STUBS
state.add_spy = function(spy)
  table.insert(current.spies, 1, spy)
end

state.snapshot()  -- create initial state

return state
