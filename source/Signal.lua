--[[
	This module was written by @Vyon, and is another way to create and handle custom signals without the use of filthy instances like
	bindable events! (jokes)

	[Signal.lua]:
	[Methods]:
		New():
			Constructs an object from the signal class.

			@params: None
			@ret: (signal: Dictionary<string>)

		Connect( self, callback ):
			Creates a new thread to handle the callback.

			@params: (self: Dictionary<string>, callback: Function)
			@ret: (connection: Dictionary<string>)

		Disconnect():
			Closes the handler thread and removes it from _Connections for cleanup

			@params: None
			@ret: nil

		Fire( self, ... ):
			Loops through all saved connections and fires to each of them with the given arguments

			@params: (self: Dictionary<string>, ...: any)
			@ret: nil

		Wait():
			Yields the current thread until the fire method is used.

			@params: None
			@ret: (arguments: Array<number>)
--]]

local signal = {}
signal.__index = signal
signal.__type = 'LunarScriptSignal'

function signal.New()
	local self = setmetatable({}, signal)
	self._Connections = {}
	self._Args = nil

	return self
end

function signal:Connect(callback: any)
	local index = #self._Connections + 1
	table.insert(self._Connections, coroutine.create(callback))

	return {
		Disconnect = function()
			local routine = self._Connections[index]
			coroutine.close(routine)

			self._Connections[index] = nil
		end
	}
end

function signal:Fire(...)
	for _, routine in pairs(self._Connections) do
		coroutine.resume(routine, ...)
	end

	self._Args = {...}

	task.wait()

	self._Args = nil
end

function signal:Wait()
	local _Args = nil

	repeat _Args = self._Args task.wait() until _Args
	return _Args
end

return signal
