---@class
local event = {}

---Registers a new event listener
---@param name string name of the event to listen to
---@param callback function callback function called when the event is received
---@return number the event id which can be canceled via `event.cancel`, if the event was successfully registered, false if this function was already registered for this event type.
function event.listen(name, callback) end

---Unregister a previously registered event listener.
---@param name string name of the signal to unregister.
---@param callback function the function that was used to register for this event.
---@return boolean true if the event was successfully unregistered, false if this function was not registered for this event type.
function event.ignore(name, callback) end

---Starts a new timer that will be called after the time specified in interval.
---@param interval number time in seconds between each invocation of the callback function. Can be a fraction like 0.05.
---@param callback function the function to call.
---@param times number how many times the function will be called. If omitted the function will be called once. Pass math.huge for infinite repeat.(Optional)
---@return number a timer ID that can be used to cancel the timer at any time.
function event.timer(interval, callback, times) end

---Pulls and returns the next available event from the queue, or waits until one becomes available.
---@param timeout number if passed the function will wait for a new event for this many seconds at maximum then returns nil if no event was queued during that time.(Optional)
---@param name number an event pattern that will act as a filter.(Optional)
---@param ... vararg any number of parameters in the same order as defined by the signal that is expected. Those arguments will act as filters for the additional arguments returned by the signal. Direct equality is used to determine if the argument is equal to the given filter. Can be nil in which case this particular argument will not be filtered.
---@return string, table
function event.pull(timeout, name, ...) end

---Pulls and returns the next available event from the queue, or waits until one becomes available but allows filtering by specifying filter function.
---@param timeout number function will wait for a new event for this many seconds at maximum then returns nil if no event was queued during that time.(Optional)
---@param filter function filtering function of events. Allows for advanced filtering.(Optional)
---@return string, table
function event.pullFiltered(timeout, filter) end

---Pulls multiple events
---@param ... vararg
---@return table
function event.pullMultiple(...) end

---Global event callback error handler. If an event listener throws an error, we handle it in this function to avoid it bubbling into unrelated code (that only triggered the execution by calling event.pull).
---Per default, this logs errors into a file on the temporary file system.
---You can replace this function with your own if you want to handle event errors in a different way.
---@param message any
function event.onError(message) end

---Pushes a signal(event)
---@param name string signal name
---@param ... vararg signal data
function event.push(name, ...) end

return event