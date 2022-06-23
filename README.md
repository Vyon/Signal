# Signal
This "class" was written by @Vyon, and is used to replicate the functionality of RBXScriptSignals with an added touch.
Kinda wish roblox had decided to make the RBXScriptSignal class usable, but they didn't lmao.

# Documentation

## Signal.New
Creates a new Signal object.

	@params: nil
	@ret: (Signal: signal)

## Signal:Connect
Connects a function to the Signal.

	@params: (Function: any)
	@ret: (Connection: Connection)

## Signal:ConnectOnce
Like Signal:Connect but instead disconnects the function after 1 call.

	@params: (Function: any)
	@ret: (Connection: Connection)

## Signal:Fire
Calls all connection callbacks.

	@params: (...: any)
	@ret: nil
	
## Signal:Wait
Waits for the signal to fire.

	@params: nil
	@ret: (...: any)

## Signal:DisconnectAll
Disconnects all functions from the Signal.

	@params: nil
	@ret: nil

## Signal:Destroy
Alias for "DisconnectAll"

	@params: nil
	@ret: nil

## Connection.New
Creates a new Connection object.

	@params: (Signal: signal, Func: any)
	@ret: (Connection: Connection)

## Connection:Disconnect
Disconnects the given connection from the Signal object.

	@params: nil
	@ret: nil