' Constructor
'
' Public connector/interface for the library that can be used from SceneGraph components rather than calling
' the Task node directly
'
' Required params:
' task SegmentAnalyticsTask node instance

function SegmentAnalyticsConnector(task as object)
  return {
    init: _SegmentAnalyticsConnector_init

    identify: _SegmentAnalyticsConnector_identify
    track: _SegmentAnalyticsConnector_track
    screen: _SegmentAnalyticsConnector_screen
    group: _SegmentAnalyticsConnector_group
    alias: _SegmentAnalyticsConnector_alias

    'private
    _task: task

    _callEvent: _SegmentAnalyticsConnector_callEvent
  }
end function

' Should be the first function you invoke when using the segment analytics library
' Required params:
' @config an associative array that contains a writeKey property for the segment analytics library

sub _SegmentAnalyticsConnector_init(config as object)
  m._task.config = config
  m._task.control = "run"
end sub

' Bridges to the segment analytics library's identify method
' Required params:
' @userId string to identify the user with
' Optional params:
' @traits
' @options

sub _SegmentAnalyticsConnector_identify(userId as string, traits = invalid as dynamic, options = invalid as dynamic)
  m._callEvent("identify", {
    userId: userId
    traits: traits
    options: options
  })
end sub

' Bridges to the segment analytics library's track method
' Required params:
' @event
' @options
' Optional params:
' @properties

sub _SegmentAnalyticsConnector_track(event as object, properties = invalid as dynamic, options = {} as object)
  m._callEvent("track", {
    event: event
    properties: properties
    options: options
  })
end sub

' Bridges to the segment analytics library's screen method
' Required params:
' @name
' @options
' Optional params:
' @category
' @properties

sub _SegmentAnalyticsConnector_screen(name as string, category = invalid as dynamic, properties = invalid as dynamic, options = {} as object)
  m._callEvent("screen", {
    name: name
    category: category
    properties: properties
    options: options
  })
end sub

' Bridges to the segment analytics library's group method
' Required params:
' @groupId
' @options
' Optional params:
' @traits

sub _SegmentAnalyticsConnector_group(userId as string, groupId as string, traits = invalid as dynamic, options = {} as object)
  m._callEvent("group", {
    userId: userId
    groupId: groupId
    traits: traits
    options: options
  })
end sub

' Helps segment analytics merge multiple identities from one user within the running application
' Required params:
' @newId
' @options

sub _SegmentAnalyticsConnector_alias(userId as string, options = {} as object)
  m._callEvent("alias", {
    userId: userId
    options: options
  })
end sub

sub _SegmentAnalyticsConnector_callEvent(name as string, payload as object)
  if payload.options = invalid
    payload.options = {}
  end if

  if payload.options.timestamp = invalid
    dateTime = createObject("roDateTime")
    payload.options.timestamp = dateTime.ToIsoString()
  end if
  m._task.event = { name: name, payload: payload }
end sub