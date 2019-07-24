---@class
local modem = {}

--Checks if this modem is capable of sending wireless messages.
--@return whether this modem is capable of sending wireless messages.
function modem.isWireless() end

--Returns the maximum packet size for sending messages via network cards. Defaults to 8192.
--Every value in a message adds two bytes of overhead. (Even if there's only one value.)
--Numbers add another 8 bytes, true/false/nil another 4 bytes, and strings exactly as many bytes as the string 
--contains—though empty strings still count as one byte.
--@return the maximum packet size for sending messages via network cards.
function modem.maxPacketSize() end

--Opens the specified port number for listening (max 65535). 
--@return true if the port was opened, false if it was already open.
function modem.open(port) end

--Returns whether the specified “port” is currently being listened on.
--Messages only trigger signals when they arrive on a port that is open.
--@return whether the specified “port” is currently being listened on. 
function modem.isOpen(port) end

--Closes the specified port (default: all ports). 
--@return true if ports were closed.
function modem.close(port) end

--Sends a network message to the specified address.
--Returns true if the message was sent. This does not mean the message was received, only that it was sent. No port-sniffing for you.
--Any additional arguments are passed along as data. These arguments must be basic types: nil, boolean, number and string values are supported, tables and functions are not
--@return true if the message was sent.
function modem.send(address, port, ...) end

--Sends a broadcast message. This message is delivered to all reachable network cards.
--@return true if the message was sent.
function function_name(port, ...) end