---@class
local serialization = {}

---Generates a string from an object that can be parsed again using serialization.unserialize
---The pretty mode can be used to generate output for display to the user, this output will in most circumstances not be readable with serialization.unserialize.
---The value of pretty defines the number of entries that will be printed.
---If pretty is set to true it will by default print 10 entries.
---This function can be useful for sending messages via a network card.
---@param value any basic types (nil, boolean, number, string) and tables without cycles (will error out when cycles are detected, unless in pretty print mode).
---@param pretty any boolean/number.(Optional)
function serialization.serialize(value, pretty) end

---Restores an object previously saved with serialization.serialize.
---@param value string value from serialization.serialize.
---@return any unserialized object
function serialization.unserialize(value) end
return serialization