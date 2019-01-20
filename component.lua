
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







--endregion inventory_controller


return component
