This is a scripting reference intended for the level designers.
If you would like something added or clarified, please PM Centauri Soldier.

This contains general instruction on how to implement
scripts and detailed info on those scripts.


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

The external method type means that the function was
designed to be used by you to design levels. The internal
type means that it is used by other functions and should not
be used by you as they are not "safe", meaning that conditions
and arguments types or values are not checked since they are
assumed by the calling functions: It is not reccommended that
you use these. If you need to use one of the internal methods,
please notify Centauri Soldier and a "safe" version of the
function will be created for you.

If one of the arguments is 'variable', that means that it
may be any of the types listed above under return types.