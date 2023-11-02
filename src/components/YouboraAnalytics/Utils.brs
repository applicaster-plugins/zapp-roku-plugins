function currentMillis() as longinteger

  date = CreateObject("roDateTime")
  seconds& = date.AsSeconds() 'seconds is long
  seconds& = seconds& * 1000

  millis& = date.GetMilliseconds()

  return seconds& + millis&

end function

sub YouboraLog(message as string, contextName as string)
  try
    if m.YouboraLogActive = invalid
      m.YouboraLogActive = m.global.YouboraLogActive
    end if
    if m.YouboraLogActive = true
      timeStamp = getCurrentTime()
      print "[" + timeStamp + "] (" + contextName + ") " + message
    end if
  catch e
  end try
end sub

function getCurrentTime() as string
  result = "{0}.{1}"
  time = CreateObject("roDateTime")
  time.toLocalTime()
  result = Substitute(result, time.ToISOString(), time.getMilliseconds().toStr())
  return result
end function

' Extracted from https://github.com/Roberto14/CompareAA

function CompareAA(aa1, aa2) as boolean

  if aa1 = invalid or aa2 = invalid return false
  if aa1.Count() <> aa2.Count() return false

  equals = true
  i = 0
  for each prop in aa1
    if isArray(aa1) then prop = i

    if DoesExist(aa2, prop) then
      if type(aa1[prop]) = "roAssociativeArray" or isArray(aa1[prop])
        if type(aa1[prop]) = type(aa2[prop])
          equals = CompareAA(aa1[prop], aa2[prop])
        else
          equals = false
        end if
      else
        if type(aa1[prop]) <> type(aa2[prop])
          equals = false
        else
          if aa1[prop] <> aa2[prop] then
            equals = false
          end if
        end if
      end if
    else
      equals = false
    end if

    'break the cicle if false is found
    if not equals then exit for
    i = i + 1
  next

  return equals
end function

function DoesExist(array, prop) as boolean

  if type(array) = "roAssociativeArray" return array.DoesExist(prop)

  found = false
  for i = 0 to array.Count() - 1
    if i = prop then found = true : exit for
  next
  return found
end function

function isArray(obj) as boolean
  if obj = invalid return false
  if GetInterface(obj, "ifArray") = invalid return false
  return true
end function
