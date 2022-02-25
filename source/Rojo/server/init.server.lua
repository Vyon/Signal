local signal = require(script.Signal).New()
local connection = signal:Connect(function(...)
	print(...)
end)

task.spawn(function()
	task.wait(2)
	signal:Fire('Hello', 'World!')

	connection.Disconnect()
end)

signal:Wait()