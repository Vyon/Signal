# Signal
This module was written by @Vyon, and is another way to create and handle custom signals without the use of filthy instance modules that use bindable events! (jokes)

Feel free to modify to your hearts desire

# Methods
## New():
	Constructs an object from the signal class.

	@params: None
	@ret: (signal: Dictionary<string>)

## Connect( self, callback ):
	Creates a new thread to handle the callback.
	
	@params: (self: Dictionary<string>, callback: Function)
	@ret: (connection: Dictionary<string>)

## Disconnect():
	Closes the handler thread and removes it from _Connections for cleanup
			
	@params: None
	@ret: nil

## Fire( self, ... ):
	Loops through all saved connections and fires to eachof them with the given arguments
	
	@params: (self: Dictionary<string>, ...: any)
	@ret: nil

## Wait():
	Yields the current thread until the fire method is used.
			
	@params: None
	@ret: (arguments: Array<number>)
