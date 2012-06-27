-- $Id: main.lua 4534 2009-05-04 23:35:06Z licho $

do  --  wrap print() in a closure
  local origPrint = print
  print = function(arg1,...)
    if (arg1) then
      arg1 = Script.GetName() .. ': ' .. tostring(arg1)
    end
    origPrint(arg1, ...)
  end
end


function tprint(t)
  for k,v in pairs(t) do
    Spring.Echo(k, tostring(v))
  end
end


local allModOptions = Spring.GetModOptions()
function Spring.GetModOption(s,bool,default)
  if (bool) then
    local modOption = allModOptions[s]
    if (modOption==nil) then modOption = (default and "1") end
    return (modOption=="1")
  else
    local modOption = allModOptions[s]
    if (modOption==nil) then modOption = default end
    return modOption
  end
end


if (Spring.GetModOption("camode")=="deploy")or
   (Spring.GetModOption("camode")=="tactics")
then

  -----------------------------
  -- DEPLOYMENT MODE
  -----------------------------
  if (not Spring.IsDevLuaEnabled()) then
    VFS.Include(Script.GetName() .. "/Deploy/main.lua", nil, VFS.ZIP_ONLY)
    Spring.Echo("LUARULES-DRAW  (DEPLOYMENT)")
  else
    VFS.Include(Script.GetName() .. "/Deploy/main.lua", nil, VFS.ZIP_ONLY)
    Spring.Echo("LUARULES-DRAW  (DEPLOYMENT)  --  DEVMODE")
  end

else

  -----------------------------
  -- NORMAL MODE
  -----------------------------
  if (not Spring.IsDevLuaEnabled()) then
    VFS.Include(Script.GetName() .. '/gadgets.lua', nil, VFS.ZIP_ONLY)
    Spring.Echo("LUARULES-DRAW  (GADGETS)")
  else
    VFS.Include(Script.GetName() .. '/gadgets.lua', nil, VFS.ZIP_ONLY)
    Spring.Echo("LUARULES-DRAW  (GADGETS)  --  DEVMODE")
  end

end


