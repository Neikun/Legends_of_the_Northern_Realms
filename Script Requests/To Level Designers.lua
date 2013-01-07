<<Please refer to this document for all of your scripting questions. It will
be updated regularly and should be considered the main info document for all
scripting done by the scripting team. Should you have scripting ideas or requests,
please post them in a text file within the 'Script Requests' folder inside
this folder using your name as the filename. Should you have a
question that is not answered here, please feel free to contact Centauri Soldier or any other of the scripters detailed in the Official Thread.>>

[Overview]
This is a scripting reference intended for the level designers.
If you would like something added or clarified, please use the
method(s) mentioned above.

[Purpose]
This contains general instructions on how to implement
scripts during level design and detailed info on those
scripts.

[Basic Information Regarding Script Module Layout]
All methods will have a header with the following information.
--[[
-----------------------------------
Class.Method(arg1type,arg2type,etc)
Return Type: string, nil, number,
			 table, boolean or
			 function
Method Type: internal or external
-----------------------------------
function script
]]

	{Class.Method}
	The Class is the name (and namespace) of the module
	while the method is the specific function that's to
	be called.

		{Arguments}
		The arguments' types and numbers will range depending on
		the method. If one of the arguments is 'variable', that
		means that it may be any of the types listed above under
		"Return Type".

	{Return Types}
	These also will vary depending on the method. This is the
	value that the function will send back to the caller when
	it has terminated.

	{Method Types}
	The external method type means that the function was
	designed to be used by you to design levels. The internal
	type means that it is used by other functions and should not
	be used by you as they are not "safe", meaning that conditions
	and argument types or values are not checked since they are
	assumed by the calling functions: It is not recommended that
	you use these. If you need to use one of the internal methods,
	please notify Centauri Soldier and a "safe" version of the
	function will be created for you.