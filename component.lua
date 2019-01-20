
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


return component
