function Chrono() as object

  this = CreateObject("roAssociativeArray")

  this.date = CreateObject("roDateTime")

  this.startTime = invalid
  this.stopTime = invalid

  this.start = function() as void
    m.startTime = m.currentMillis()
    m.stopTime = invalid
  end function

  this.stop = function() as integer
    m.stopTime = m.currentMillis()
    return m.getDeltaTime()
  end function

  this.getDeltaTime = function(stopIfNeeded = invalid) as integer

    if m.startTime = invalid
      return -1
    end if

    if m.stopTime = invalid
      if stopIfNeeded = true
        return m.stop()
      else
        return m.currentMillis() - m.startTime
      end if
    else
      return m.stopTime - m.startTime
    end if
  end function

  'Return the current timestamp in millis
  this.currentMillis = function() as longinteger
    m.date.Mark() 'Read time

    seconds& = m.date.AsSeconds() 'seconds# is long
    seconds& = seconds& * 1000

    millis& = m.date.GetMilliseconds()
    return seconds& + millis&
  end function

  this.getStartTime = function() as longinteger
    return m.startTime
  end function

  this.setStartTime = function(newStartTime as longinteger) as void
    m.startTime = newStartTime
  end function

  this.reset = function() as void
    m.startTime = invalid
    m.stopTime = invalid
  end function

  return this
end function
