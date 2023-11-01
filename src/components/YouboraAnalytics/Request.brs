' ********** Copyright 2023 Nice People At Work.  All Rights Reserved. **********

'Request.brs

function Request(messagePort) as object

  YouboraLog("Created Request", "Request")
  this = CreateObject("roAssociativeArray")

  'Methods
  this.getUrl = Request_getUrl
  this.getQuery = Request_getQuery
  this.send = Request_send

  'Fields
  this.host = ""
  this.service = ""
  this.args = {}

  this.request = CreateObject("roUrlTransfer")
  this.request.SetMessagePort(messagePort)

  return this
end function

function Request_send() as boolean

  url = m.getUrl()
  m.request.SetUrl(url)
  YouboraLog("XHR Req: " + url, "Request")

  'We need a little setup if the request is https
  'if url.Left(5) = "https"
    m.request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    m.request.AddHeader("X-Roku-Reserved-Dev-Id", "")
    m.request.InitClientCertificates()
  'end if

  'Send
  return m.request.AsyncGetToString()
end function


function Request_getUrl() as string
  return m.host + m.service + m.getQuery()
end function

function Request_getQuery() as string

  if m.args <> invalid and m.args.IsEmpty() = false
    query$ = "?"

    for each paramKey in m.args

      paramValue = m.args[paramKey]

      if paramValue <> invalid
        if type(paramValue) = "roArray" or type(paramValue) = "roAssociativeArray"
          query$ = query$ + m.request.Escape(paramKey) + "=" + m.request.Escape(FormatJson(paramValue)) + "&"
        else if paramValue.ToStr() <> ""
          query$ = query$ + m.request.Escape(paramKey) + "=" + m.request.Escape(paramValue.ToStr()) + "&"
        end if
      end if
    end for

    'Remove last ampersand
    query$ = Left(query$, Len(query$) - 1)

    return query$
  end if

  return ""
end function