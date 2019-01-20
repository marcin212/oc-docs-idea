---@class item
---@field public damage number the current damage value of the item.
---@field public maxDamage number the maximum damage this item can have before it breaks.
---@field public size number the current stack size of the item.
---@field public maxSize number the maximum stack size of this item.
---@field public id number the Minecraft id of the item. Note that this field is only included if insertIdsInConverters=true in the configs, and can vary between servers!
---@field public name string the untranslated item name, which is an internal Minecraft value like oc:item.FloppyDisk
---@field public label string the translated item name
---@field public hasTag boolean whether or not the item has an NBT tag associated with it.
local item={}

---@class component
---@field public inventory_controller inventory_controller
---@field public modem modem
local component = {}




--region inventory_controller
---@class inventory_controller
local inventory_controller = {}

---Returns the size of the inventory at the specified side.
---@param side number must be a valid side
---@return number,string Returns the size of the inventory, or nil followed by a description why this function failed (usually no inventory)
function inventory_controller.getInventorySize(side) end

---Returns a table describing the item in the specified slot or nil.
---@param slot number the slot to analyze. This does not check the inventory size and will consider slots outside the inventory bounds to be empty.
---@param side number must be a valid side
---@return item nil if the slot was empty (or outside the inventory's bounds), a table otherwise with the information about the item in that slot
function inventory_controller.getStackInSlot(side, slot) end

---Gets Itemstack description of item in specified or selected slot (if no input provided) of robot inventory.
---@param slot number the slot to analyze.
---@return item nil if the slot was empty
function inventory_controller.getStackInInternalSlot(slot) end

--endregion inventory_controller

--region modem
---This component is provided by network cards. Wireless network cards behave much like normal network cards, but additionally send the message as a wireless “packet” when a strength is set.
---The modem's address must be used for networking. It can be found through component.modem.address.
---@class modem
local modem = {}

---Returns whether this modem is capable of sending wireless messages.
---@return boolean true if the modem is wireless
function modem.isWireless() end

---Returns the maximum packet size for sending messages via network cards. Defaults to 8192. You can change this in the OpenComputers configuration file.
---Every value in a message adds two bytes of overhead. (Even if there's only one value.)
---@return number packet size
function modem.maxPacketSize() end

---Returns whether the specified “port” is currently being listened on.
---@param port number the port to check
---@return boolean whether the port is open
function modem.isOpen(port) end

---Opens the specified port number for listening. Messages only trigger signals when they arrive on a port that is open.
---@param port number the port to open
---@return boolean true when was already opened
function modem.open(port) end

---Closes the specified port.
---@param port number port to close.(Optional, defaults to all ports)
---@return boolean true if ports were closed.
function modem.close(port) end

---Sends a network message to the specified address.
---Any additional arguments are passed along as data.
---@param address string address to send to
---@param port number port to send to
---@param data any
---@return boolean true if the message was sent. This does not mean the message was received, only that it was sent. No port-sniffing for you.
function modem.send(address, port, data) end

---Sends a broadcast message. This message is delivered to all reachable network cards. Broadcast messages are not delivered to the modem that sent the message.
---@param port number port to send to
---@param data any
---@return boolean true if the message was sent.
function modem.broadcast(port, data) end

---The current signal strength to apply when sending messages. Wireless network cards only.
---@return number strength
function modem.getStrength() end

---Sets the signal strength. If this is set to a value larger than zero, sending a message will also generate a wireless message. The higher the signal strength the more energy is required to send messages, though. Wireless network cards only.
---@param value number strength value
---@return number
function modem.setStrength(value) end

---Gets the current wake-up message. When the network card detects the wake message (a string in the first argument of a network packet), on any port and the machine is off, the machine is started.
---Works for robots, cases, servers, drones, and tablets. Linked Cards provide this same functionality.
---@return string current message
function modem.getWakeMessage() end

---Sets the wake-up message to the specified string.
---@param fuzzy boolean ignores additional trailing arguments in the network packet.
---@return string
function modem.setWakeMessage(message, fuzzy) end

--endregion modem


return component
