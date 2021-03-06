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

---@class baseComponent: table
local baseComponent = {}

---@class component
---@field public inventory_controller inventory_controller
---@field public modem modem
local component = {}

--region component

---Returns the documentation string for the method with the specified name of the component with the specified address, if any.
---Note that you can also get this string by using tostring on a method in a proxy, for example tostring(component.screen.isOn).
---@param address string component address.
---@param method string method name.
---@return string the documentation string.
function component.doc(address, method) end

---Calls the method with the specified name on the component with the specified address, passing the remaining arguments as arguments to that method.
---Returns the result of the method call, i.e. the values returned by the method. Depending on the called method's implementation this may throw.
---@param address string component address.
---@param method string method name.
---@param ... any arguments to specified method.
---@return any the result of the method call
function component.invoke(address, method, ...) end

---Returns a table with all components currently attached to the computer, with address as a key and component type as a value.
---It also provides iterator syntax via __call, so you can use it like so: for address, componentType in component.list() do ... end
---If filter is set this will only return components that contain the filter string (this is not a pattern/regular expression).
---For example, component.list("red") will return redstone components.
---If true is passed as a second parameter, exact matching is enforced, e.g. red will not match redstone.
---@param filter string component filter (Optional)
---@param exact boolean If true is passed, exact matching is enforce (Optional)
---@return function iterator
function component.list(filter, exact) end

---Returns a table with the names of all methods provided by the component with the specified address.
---The names are the keys in the table, the values indicate whether the method is called directly or not.
---@param address string component address
---@return table<string,boolean> table with the names of all methods provided by the component
function component.methods(address) end


---Gets a 'proxy' object for a component that provides all methods the component provides as fields, so they can be called more directly (instead of via invoke).
---This is what's used to generate 'primaries' of the individual component types, i.e. what you get via component.blah.
---For example, you can use it like so: component.proxy(component.list("redstone")()).getInput(sides.north), which gets you a proxy for the first redstone component returned by the component.list iterator, and then calls getInput on it.
---Note that proxies will always have at least two fields, type with the component's type name, and address with the component's address.
---@param address string component address
---@return baseComponent component
function component.proxy(address) end

---Get the component type of the component with the specified address.
---@param address string component address
---@return string component type
function component.type(address) end

---Return slot number which the component is installed into. Returns -1 if it doesn't otherwise make sense.
---@param address string component address
---@return string slot number which the component is installed into
function component.slot(address) end

---Undocumented
---@param address string component address
---@return string
function component.fields(address) end

---Tries to resolve an abbreviated address to a full address.
---Returns the full address on success, or nil and an error message otherwise.
---Optionally filters by component type.
---@param address string component address
---@param componentType string component type (Optional)
---@return string, string the full address on success, or nil and an error message otherwise.
function component.get(address, componentType) end

---Checks if there is a primary component of the specified component type.
---@param componentType string component type
---@return boolean
function component.isAvailable(componentType) end

---Gets the proxy for the primary component of the specified type.
---Throws an error if there is no primary component of the specified type.
---@param componentType string component type
---@return baseComponent  primary component of the specified type or throw error
function component.getPrimary(componentType) end

---Sets a new primary component for the specified component type.
---The address may be abbreviated, but must be valid if it is not nil.
---Triggers the component_unavailable and component_available signals if set to nil or a new value, respectively.
---@param componentType string component type
---@param address string component address
function component.setPrimary(componentType, address) end

--endregion component

--region inventory_controller
---@class inventory_controller: baseComponent
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

---Puts up to count items from the currently selected slot into the specified slot of the inventory at the specified side.
---If the currently selected slot is occupied, then the items will be stacked with similar items in the robot's inventory or moved to the next free slot if available. If no slot is available this operation will fail.
---Note that the robot cannot drop items into it's own inventory, attempting to do so will cause this to throw an error. You need to use robot.transferTo from the Robot API to do so.
---@param side number a valid side.
---@param slot number the slot to drop the item into.
---@param count number how many items to transfer.(Optional)
---@return boolean, string true if at least one item was moved, false and a secondary result that describes the error otherwise.
function inventory_controller.dropIntoSlot(side, slot, count) end

---Swaps the content of the robot's tool slot with the content of the currently selected inventory slot.
---Note that you can put any kind of item into the robot's tool slot, not only tools, even items that the robot cannot use at all.
---@return boolean true if the items were swapped, false otherwise. This operation usually succeeds.
function inventory_controller.equip() end

---Stores the Itemstack description of the item from the specified slot in an inventory on the specified side, into a specified database slot with the specified address.
---@param side number a valid side.
---@param slot number slot in an inventory.
---@param dbAddress string database address.
---@param dbSlot number slot in database.
---@return boolean true if success
function inventory_controller.store(side, slot, dbAddress, dbSlot) end

---Stores Itemstack description of item in specified robot inventory slot into specified database slot with the specified database address.
---@param slot number slot in an inventory.
---@param dbAddress string database address.
---@param dbSlot number slot in database.
---@return boolean true if success.
function inventory_controller.storeInternal(slot, dbAddress, dBslot) end

---Compare Itemstack description in specified slot with one in specified slot of a database with specified address.
---@param slot number slot in an inventory.
---@param dbAddress string database address.
---@param dbSlot number slot in database.
---@return boolean true if items match.
function inventory_controller.compareToDatabase(slot, dBaddress, dBslot) end

---Checks to see if Itemstack descriptions in specified slotA and slotB of inventory on specified side match. Returns true if identical.
---@param slotA number slot in an inventory.
---@param slotB number slot in an inventory.
---@param side number a valid side.
---@return boolean Returns true if identical.
function inventory_controller.compareStacks(side, slotA, slotB) end

---Gets maximum number of items in specified slot in inventory on the specified side.
---@param side number a valid side.
---@param slot number slot in an inventory.
---@return number maximum number of items in specified slot
function inventory_controller.getSlotMaxStackSize(side, slot) end

---Gets number of items in specified slot in inventory on the specified side.
---@param side number a valid side.
---@param slot number slot in an inventory.
---@return number of items in specified slot
function inventory_controller.getSlotStackSize(side, slot) end

--endregion inventory_controller

--region modem
---This component is provided by network cards. Wireless network cards behave much like normal network cards, but additionally send the message as a wireless “packet” when a strength is set.
---The modem's address must be used for networking. It can be found through component.modem.address.
---@class modem: baseComponent
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
