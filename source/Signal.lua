--[[
	[Signal.lua]:
		This "class" was written by @Vyon, and is used to replicate the functionality of RBXScriptSignals with an added touch.
		Kinda wish roblox had decided to make the RBXScriptSignal class usable, but they didn't lmao.

	[DOCUMENTATION]:
		[Signal Methods]:
			[Signal.New]: - Creates a new Signal object.
				@params: nil
				@ret: (Signal: signal)

			[Signal:Connect]: - Connects a function to the Signal.
				@params: (Function: any)
				@ret: (Connection: Connection)

			[Signal:ConnectOnce]: - Like Signal:Connect but instead disconnects the function after 1 call.
				@params: (Function: any)
				@ret: (Connection: Connection)

			[Signal:Fire]: - Calls all connection callbacks.
				@params: (...: any)
				@ret: nil

			[Signal:Wait]: - Waits for the Signal to fire.
				@params: nil
				@ret: (...: any)

			[Signal:DisconnectAll]: - Disconnects all functions from the Signal.
				@params: nil
				@ret: nil

			[Signal:Destroy]: - Alias for "DisconnectAll".
				@params: nil
				@ret: nil

		[Connection Methods]:
			[Connection.New]: - Creates a new Connection object.
				@params: (Signal: signal, Func: any)
				@ret: (Connection: Connection)

			[Connection:Disconnect]: - Disconnects the given connection from the Signal object.
				@params: nil
				@ret: nil
--]]

-- Types:
type Signal = {
	Callbacks: Array<any>,
	Connections: Array<any>,
	Args: any
}

type Connection = {
	Function: any,
	Signal: Signal,
	ConnectionId: number,
	IsConnected: boolean
}

-- Main Module:
local connection = {}
connection.__index = connection

-- Connections Methods:
function connection.New(signal: Signal, func: any)
	local self = {}
	self.Function = func
	self.Signal = signal
	self.ConnectionId = #signal.Connections + 1
	self.IsConnected = true

	return setmetatable(self, connection)
end

function connection:Disconnect()
	self.IsConnected = false
	self.Signal.Connections[self.ConnectionId] = nil
	self.Signal = nil

	setmetatable(self, nil)
end

local signal = {}
signal.__index = signal

-- Signal Methods:
function signal.New()
	local self = setmetatable({}, signal)
	self.Connections = {}
	self.Args = nil

	return self
end

function signal:Connect(callback: any)
	local conn: Connection = connection.New(self, callback)
	table.insert(self.Connections, conn)

	return conn
end

function signal:ConnectOnce(callback: any)
	local conn: Connection

	conn = connection.New(self, function(...)
		conn:Disconnect()
		pcall(callback, ...)
	end)

	table.insert(self.Connections, conn)

	return conn
end

function signal:DisconnectAll()
	for i = 1, #self.Connections do
		self.Connections[i]:Disconnect()
	end
end

function signal:Fire(...: any)
	for _, conn: Connection in ipairs(self.Connections) do
		task.spawn(conn.Function, ...)
	end

	self.Args = {...}

	task.wait()

	self.Args = nil
end

function signal:Wait()
	local args = nil

	repeat args = self._Args task.wait() until args

	return unpack(args)
end

function signal:Destroy()
	self:DisconnectAll()
end

return signal