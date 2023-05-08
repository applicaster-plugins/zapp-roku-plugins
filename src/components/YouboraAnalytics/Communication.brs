sub init()
  YouboraLog("Created Communication", "Communication")

  'Fields
  m.port = createObject("roMessagePort")
  m.preloaders = CreateObject("roList")
  m.preloaders.AddTail("FastData")
  m.validFDResponse = true
  m.requests = {}

  m.requestHost = "a-fds.youborafds01.com"
  m.view = -1

  m.startedRequests = CreateObject("roList")

  m.top.observeField("request", m.port)
  m.top.observeField("addPreloader", m.port)
  m.top.observeField("removePreloader", m.port)
  m.top.observeField("invalidFastDataResponse", m.port)
  m.top.observeField("requestHost", m.port)
  m.top.observeField("nextView", m.port)
  m.top.observeField("close", m.port)

  'Init ourselves
  m.top.functionName = "_run"
  m.top.control = "RUN"

  m.sessionStarted = false

end sub


sub _run()
  m.httpSecure = m.top.httpSecure
  'Endless loop to listen for events
  while true

    msg = wait(0, m.port)
    mt = type(msg)

    if mt = "roSGNodeEvent"
      if msg.getField() = "request"
        reqInfo = msg.getData()
        service = reqInfo.service
        args = reqInfo.args
        sendRequest(service, args)
      else if msg.getField() = "addPreloader"
        preloader = msg.getData()
        addPreloader(preloader)
      else if msg.getField() = "removePreloader"
        preloader = msg.getData()
        removePreloader(preloader)
      else if msg.getField() = "invalidFastDataResponse"
        YouboraLog("[Warning] Invalid FastData Response received!! Value: " + msg.getData().ToStr(), "Communication")
        if msg.getData()
          m.validFDResponse = false
          cleanQueue()
        end if
      else if msg.getField() = "requestHost"
        ' This will get executed before removing the preloader, so we make sure of saving the host just in case
        m.requestHost = m.top.requestHost
        setHost(m.requestHost)
      else if msg.getField() = "nextView"
        dict = msg.getData()
        _nextView()
      else if msg.getField() = "close"
        exit while
      end if

    else if mt = "roUrlEvent" 'request response
      code = msg.GetResponseCode()
      if code = 200
        YouboraLog("Request ok", "Communication")
      else
        YouboraLog("Invalid request response, code: " + code.ToStr() + ", reason: " + msg.GetFailureReason(), "Communication")
      end if

      responseSourceIdentity = msg.GetSourceIdentity()

      length = m.startedRequests.Count()
      index = length - 1

      requestsAux = CreateObject("roList")

      while index >= 0
        req = m.startedRequests[index]
        if responseSourceIdentity <> req.GetIdentity()
          'Save the other requests
          requestsAux.Push(req)
        end if
        index = index - 1
      end while

      m.startedRequests = requestsAux

    end if

  end while
end sub

function getHost() as string
  return addProtocol(m.host, m.httpSecure)
end function

sub addPreloader(preloader as string)
  m.preloaders.AddTail(preloader)
end sub

sub removePreloader(preloader as string)
  length = m.preloaders.Count()
  index = length - 1
  preloadersAux = CreateObject("roList")

  while index >= 0
    pre = m.preloaders[index]
    if pre <> preloader
      preloadersAux.Push(pre)
    end if
    index = index - 1
  end while

  m.preloaders = preloadersAux

  if preloader = "FastData"
    'Move requests from 'nocode' to the proper queue
    nocodeRequests = m.requests["nocode"]
    'Save the updated data

    topFields = m.top.getFields()

    m.code = topFields["code"]
    m.requestHost = topFields["requestHost"]
    m.pingTime = topFields["pingTime"]
    m.youboraId = topFields["youboraId"]

    if nocodeRequests <> invalid and nocodeRequests.Count() > 0
      m.requests[getViewCode()] = nocodeRequests
      m.requests["nocode"] = []
    end if

  end if

  if m.preloaders = invalid or m.preloaders.Count() = 0
    processRequests()
  end if

end sub

sub sendRequest(service, args = invalid)
  if args = invalid
    args = {}
  end if
  YouboraLog("Service: " + service, "Communication")
  'Remove code
  args.delete("code")

  req = Request(m.port)
  req.service = service
  req.args = args

  registerRequest(req)

end sub

sub registerRequest(req)
  viewCode = getViewCode()
  reqs = m.requests
  if reqs.DoesExist(viewCode) = false
    m.requests[viewCode] = []
  end if

  if m.validFDResponse = false
    YouboraLog("[Warning] The request cannot be registered because FastData did not provide a valid response", "Communication")
    return
  end if

  currentQueueSize = queueSize(viewCode)
  if currentQueueSize >= YouboraConstants().QUEUE_LIMIT_SIZE
    YouboraLog("[Warning] Request queue size for code " + viewCode + " has reached the limit (Queue size: " + currentQueueSize.ToStr() + ")", "Communication")
    return
  end if

  req.args.timemark = currentMillis().ToStr()

  m.requests[viewCode].Push(req)
  processRequests()

end sub

sub cleanQueue()
  YouboraLog("[Warning] Clean events queue", "Communication")
  for each viewCode in m.requests
    m.requests.delete(viewCode)
  end for
end sub

function queueSize(viewCode as string)
  try
    reqs = m.requests

    if reqs = invalid or viewCode = invalid
      return 0
    end if

    if reqs.DoesExist(viewCode) = false
      return 0
    else
      return reqs[viewCode].count()
    end if
  catch e
    return 0
  end try
end function

sub processRequests()

  if m.preloaders.IsEmpty() = true and m.requests.IsEmpty() = false
    for each viewCode in m.requests 'This iterates over requests's keys, ie. the view codes
      requestsForCode = m.requests[viewCode]

      for each req in requestsForCode 'For each pending request for that view code

        req.args.code = viewCode
        req.args["sessionRoot"] = getSessionRoot()
        if req.host = invalid or req.host = ""
          req.host = getHost()
        end if

        if req.service = "/start" or req.service = "/init"
          req.args["youboraId"] = m.youboraId
        end if

        if req.service = "/start" or req.service = "/init" or req.service = "/ping" or req.service = "/error"
          req.args["sessionParent"] = getSessionRoot() 'Since we won't have parent we use the same code as root
        end if

        if req.service = "/start" or req.service = "/init" or req.service = "/error"
          req.args["parentId"] = req.args["sessionRoot"]
        end if

        if (req.service = "/infinity/session/start" or req.service = "/infinity/session/stop" or req.service = "/infinity/session/nav" or req.service = "/infinity/session/event" or req.service = "/infinity/session/beat")
          req.args.Delete("code")
          req.args["sessionId"] = getSessionRoot()

          if req.service = "/infinity/session/start"
            m.sessionStarted = true
          end if

          if req.service = "/infinity/session/stop"
            m.sessionStarted = false
          end if
        end if

        req.send()

        m.startedRequests.Push(req.request)
      end for
    end for

    m.requests.Clear() 'Once sent, clear requests lists
  end if
end sub

function _nextView() as string
  m.view = m.view + 1
  vcode = getViewCode()
  return vcode
end function

function getViewCode() as string
  if m.code = invalid or m.code = ""
    return "nocode"
  else
    return m.code + "_" + m.view.ToStr()
  end if
end function

function getSessionRoot() as string
  if m.code = invalid or m.code = ""
    return "noSessionRoot"
  end if
  return m.code
end function

sub setHost(host as string)
  m.host = removeProtocol(host)
end sub

'Static
function removeProtocol(host as string) as string

  index = Instr(1, host, "//")

  if index > 0
    return Right(host, Len(host) - (index + 2))
  end if

  return host
end function

function addProtocol(host as string, httpSecure as boolean) as string

  if httpSecure = true
    proto = "https://"
  else
    proto = "http://"
  end if

  return proto + host

end function
