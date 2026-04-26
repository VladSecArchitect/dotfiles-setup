import lldb
import subprocess

def mate(debugger, command, result, dict):
	res = lldb.SBCommandReturnObject()
	comminter = debugger.GetCommandInterpreter()
	comminter.HandleCommand(command, res)
	if not res.Succeeded():
		return
	output = res.GetOutput()
	mate = subprocess.Popen(['/usr/local/bin/mate','--stay', '-'], shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	mate.stdin.write(output)
	mate.stdin.close()