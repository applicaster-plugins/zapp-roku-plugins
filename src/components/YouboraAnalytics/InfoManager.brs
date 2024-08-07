function InfoManager(plugin, options = invalid)
  YouboraLog("Created InfoManager", "InfoManager")
  this = CreateObject("roAssociativeArray")

  'Methods
  this.getRequestParams = InfoManager_getRequestParams
  this.getEntities = InfoManager_getEntities

  this.getResource = function()
    resource = m.options["content.resource"]

    if resource = invalid
      resource = m.plugin.getResource()
    end if

    if resource = invalid
      resource = "Unknown"
    end if

    return resource
  end function

  this.getParsedResource = function()
    resource = invalid

    if m.options["parse.manifest"] = true
      resource = m.plugin.getParsedResource()
    end if

    return resource

  end function

  this.getTransportFormat = function()
    format = m.options["content.transportFormat"]
    if format <> "TS" and format <> "MP4" and format <> "CMF" then
      format = invalid
    end if

    if format = invalid and m.options["parse.manifest"] = true
      resource = m.plugin.getParsedResource()
      if Instr(1, resource, ".ts") > 0 then
        format = "TS"
      else if Instr(1, resource, ".cmfv") > 0 then
        format = "CMF"
      else if Instr(1, resource, ".mp4") + Instr(1, resource, ".m4s") > 0 then
        format = "MP4"
      end if
    end if

    return format

  end function


  this.getStreamingProtocol = function()
    protocol = m.options["content.streamingProtocol"]

    if protocol <> "HDS" and protocol <> "HLS" and protocol <> "MSS" and protocol <> "DASH" and protocol <> "RTMP" and protocol <> "RTP" and protocol <> "RTSP"
      protocol = invalid
    end if

    return protocol

  end function

  this.getPlayhead = function()
    playhead = m.plugin.getPlayhead()

    if playhead = invalid
      playhead = 0.0
    end if

    return playhead
  end function

  this.getMediaDuration = function()
    duration = m.options["content.duration"]

    if duration = invalid
      duration = m.plugin.getMediaDuration()
    end if

    if duration = invalid
      duration = 0
    end if

    return duration
  end function

  this.getTitle = function()
    title = m.options.content.title

    if title = invalid
      title = m.plugin.getTitle()
    end if

    return title
  end function

  this.getPlayrate = function()
    return m.plugin.getPlayrate()
  end function

  this.getIsLive = function()
    islive = m.options["content.isLive"]

    if islive = invalid
      islive = m.plugin.getIsLive()
    end if

    if islive = invalid
      islive = false
    end if

    return islive
  end function

  this.getRendition = function()
    rendition = m.options["content.rendition"]

    if rendition = invalid
      rendition = m.plugin.getRendition()
    end if

    return rendition
  end function

  this.getSubtitles = function()
    return m.options["content.subtitles"]
  end function

  this.getBitrate = function()
    bitrate = m.plugin.getBitrate()

    if bitrate = invalid
      bitrate = -1.0
    end if

    return bitrate
  end function

  this.getThroughput = function()
    throughput = m.plugin.getThroughput()

    if throughput = invalid
      throughput = -1.0
    end if

    return throughput
  end function

  this.getTotalBytes = function()
    totalBytes = invalid

    if m.options["content.sendTotalBytes"] = true
      if m.options["content.totalBytes"] = invalid
        totalBytes = m.plugin.getTotalBytes()
      else
        totalBytes = m.options["content.totalBytes"]
      end if
    else

    end if

    return totalBytes
  end function

  this.getDeviceUUID = function()
    if m.options["device.id"] = invalid
      return CreateObject("roDeviceInfo").GetChannelClientId()
    else
      return m.options["device.id"]
    end if
  end function

  this.getDeviceInfo = function()
    deviceInfo = {}
    if m.options["device.model"] = invalid
      devInfo = CreateObject("roDeviceInfo")
      hardwareModel = devInfo.GetModel()

      deviceInfo["model"] = hardwareModel
      deviceInfo["deviceName"] = "Roku"
    else
      deviceInfo["model"] = m.options["device.model"]
      deviceInfo["deviceName"] = "Roku"
    end if

    if m.options["device.osVersion"] = invalid
      osVersion = CreateObject("roDeviceInfo").GetOSVersion()
      deviceInfo["osVersion"] = osVersion.major + "." + osVersion.minor + "." + osVersion.revision + "." + osVersion.build
    else
      deviceInfo["osVersion"] = m.options["device.osVersion"]
    end if

    if m.options["device.brand"] = invalid
      deviceInfo["brand"] = "Roku"
    else
      deviceInfo["brand"] = m.options["device.brand"]
    end if

    if m.options["device.deviceType"] <> invalid
      deviceInfo["deviceType"] = m.options["device.deviceType"]
    end if

    if m.options["device.deviceCode"] <> invalid
      deviceInfo["deviceCode"] = m.options["device.deviceCode"]
    end if

    deviceInfo["osName"] = "RokuOS"
    deviceInfo["id"] = devInfo.GetChannelClientId()
    deviceInfo["isAnonymous"] = false
    deviceInfo["type"] = devInfo.GetModelType()


    if m.options["device.browserName"] = invalid
      deviceInfo["browserName"] = ""
    else
      deviceInfo["browserName"] = m.options["device.browserName"]
    end if

    if m.options["device.browserVersion"] = invalid
      deviceInfo["browserVersion"] = ""
    else
      deviceInfo["browserVersion"] = m.options["device.browserVersion"]
    end if

    if m.options["device.deviceBrowserType"] = invalid
      deviceInfo["deviceBrowserType"] = ""
    else
      deviceInfo["deviceBrowserType"] = m.options["device.deviceBrowserType"]
    end if

    if m.options["device.browserEngine"] = invalid
      deviceInfo["browserEngine"] = ""
    else
      deviceInfo["browserEngine"] = m.options["device.model"]
    end if

    return deviceInfo
  end function


  this.getAdPosition = function()
    position = m.plugin.getAdPosition()

    if position = invalid
      position = "unknown"
    end if
    return position
  end function

  this.getAdPlayhead = function()
    adPlayhead = m.plugin.getAdPlayhead()
    if adPlayhead = invalid
      adPlayhead = 0
    end if
    return adPlayhead
  end function

  this.getAdNumber = function()
    number = m.plugin.getAdNumber()

    if number = invalid or number = 0
      number = 1
    end if
    return number
  end function

  this.getAdNumberInBreak = function()
    number = m.plugin.getAdNumberInBreak()

    if number = invalid or number = 0
      number = 1
    end if
    return number
  end function

  this.getAdDuration = function()
    duration = m.plugin.getAdDuration()

    if duration = invalid
      duration = 0
    end if
    return duration
  end function

  this.getAdTitle = function()
    return m.options["ad.title"]
  end function

  this.getAdResource = function()
    return m.options["ad.resource"]
  end function

  this.getVideoMetrics = function()
    return m.options["content.metrics"]
  end function

  'Fields
  this.plugin = plugin

  if options = invalid
    this.options = {}
  else
    this.options = options
  end if

  return this



end function

function getNestedValue(data, keyPath) as dynamic
  keys = keyPath.split(".")
  value = data
  for each key in keys
    if value <> invalid and value.DoesExist(key)
      value = value[key]
    else
      return invalid
    end if
  end for
  return value
end function


function InfoManager_getEntities() as object
  content = m.options.content
  return {
    "rendition": m.getRendition(),
    "title": m.getTitle(),
    "program": content.program,
    "cdn": content.cdn,
    "subtitles": m.getSubtitles(),
    "contentLanguage": content.language
    "user_id": content.user_id
    "app_release_version": content.app_release_version
    "app_version_number": content.app_version_number
  }
end function

function InfoManager_getRequestParams(requestName = "" as string, params = invalid)

  if params = invalid
    outParams = {}
  else
    outParams = params
  end if

  'Now is mandatory for EVERY request
  if outParams.DoesExist("accountCode") = false then outParams["accountCode"] = m.options["accountCode"]

  'For requests that create a view or a session
  if requestName = "start" or requestName = "error" or requestName = "sessionStart"
    if outParams.DoesExist("username") = false
      if m.options["user.name"] = invalid
        outParams["username"] = m.options["username"]
      else
        outParams["username"] = m.options["user.name"]
      end if
    end if
    if outParams.DoesExist("email") = false then outParams["email"] = m.options["user.email"]
    if outParams.DoesExist("obfuscateIp") = false then outParams["obfuscateIp"] = m.options["user.obfuscateIp"]
    if outParams.DoesExist("privacyProtocol") = false then outParams["privacyProtocol"] = m.options["user.privacyProtocol"]
    if outParams.DoesExist("userType") = false
      if m.options["user.type"] = invalid
        outParams["userType"] = m.options["userType"]
      else
        outParams["userType"] = m.options["user.type"]
      end if
    end if
    if outParams.DoesExist("anonymousUser") = false
      if m.options["user.anonymousId"] = invalid
        outParams["anonymousUser"] = m.options["anonymousUser"]
      else
        outParams["anonymousUser"] = m.options["user.anonymousId"]
      end if
    end if
    if outParams.DoesExist("deviceId") = false then outParams["deviceId"] = m.options["device.code"]
    if outParams.DoesExist("deviceInfo") = false then outParams["deviceInfo"] = m.getDeviceInfo()
    'if outParams.DoesExist("deviceInfo") = false then outParams["deviceInfo"] = {"model":m.getDeviceModel()}
    'Network
    if outParams.DoesExist("isp") = false then outParams["isp"] = m.options["network.isp"]
    if outParams.DoesExist("ip") = false then outParams["ip"] = m.options["network.ip"]
    if outParams.DoesExist("connectionType") = false then outParams["connectionType"] = m.options["network.connectionType"]
    'App
    if outParams.DoesExist("appName") = false then outParams["appName"] = m.options.app.name
    if outParams.DoesExist("appReleaseVersion") = false then outParams["appReleaseVersion"] = m.options.content.app_release_version
  end if

  if requestName = "data"
    if outParams.DoesExist("system") = false then outParams["system"] = m.options["accountCode"]
    if outParams.DoesExist("pluginName") = false then outParams["pluginName"] = m.plugin.getPluginName()
    if outParams.DoesExist("pluginVersion") = false then outParams["pluginVersion"] = m.plugin.getPluginVersion()
  else if requestName = "start" or requestName = "error"
    'Start and Error share most of the params, but error also has error code and error message
    ' Params
    contentAttributes = {
      "properties": "metadata"
      "cdn": "cdn"
      "program": "program"
      "saga": "saga"
      "tvshow": "tvShow"
      "season": "season"
      "titleEpisode": "episodeTitle"
      "channel": "Channel"
      "contentId": "id"
      "imdbID": "imdbId"
      "gracenoteID": "gracenoteId"
      "contentType": "type"
      "genre": "genre"
      "contentLanguage": "language"
      "contractedResolution": "contractedResolution"
      "cost": "cost"
      "price": "price"
      "playbackType": "playbackType"
      "drm": "drm"
      "videoCodec": "encoding.videoCodec"
      "audioCodec": "encoding.audioCodec"
      "codecSettings": "encoding.codecSettings"
      "codecProfile": "encoding.codecProfile"
      "containerFormat": "encoding.containerFormat"
      "dimensions": "customDimensions"
    }

    for each attribute in contentAttributes.items()
      outParams[attribute.key] = outParams[attribute.key] = invalid ? m.options.content[attribute.value] : outParams[attribute.key]
    end for

    parameterList = {
      "system": m.options["accountCode"]
      "player": m.plugin.getPluginName()
      "transactionCode": m.options["content.transactionCode"]
      "deviceUUID": m.getDeviceUUID()
      "pluginVersion": m.plugin.getPluginVersion()
      "playerVersion": m.plugin.getPlayerVersion()
      "mediaResource": m.getResource()
      "parsedResource": m.getParsedResource()
      "streamingProtocol": m.getStreamingProtocol()
      "transportFormat": m.getTransportFormat()
      "mediaDuration": m.getMediaDuration()
      "live": m.getIsLive()
      "rendition": m.getRendition()
      "title": m.getTitle()
      "subtitles": m.getSubtitles()
    }

    for each parameter in parameterList.items()
      if outParams.DoesExist(parameter["key"]) = false then
        outParams[parameter["key"]] = parameter["value"]
      end if
    end for

    nextraparams = 20
    index = 1
    while (index <= nextraparams)
      optionKey = "extraparam." + index.ToStr()
      paramKey = "param" + index.ToStr()
      optionCustomDimensionKey = "content.customDimension" + index.ToStr()
      paramValue = getNestedValue(m.options, optionKey)
      if paramValue = invalid then paramValue = getNestedValue(m.options, optionCustomDimensionKey)
      if paramValue <> invalid
        if outParams.DoesExist(paramKey) = false then outParams[paramKey] = paramValue
      end if
      index = index + 1
    end while


    'Error-specific params
    if requestName = "error"
      if outParams.DoesExist("msg") = false then outParams["msg"] = "Unknown error"
      if outParams.DoesExist("errorCode") = false then outParams["errorCode"] = 9000
    end if

  else if requestName = "join"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
  else if requestName = "pause"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
  else if requestName = "resume"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
  else if requestName = "stop"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = "-1"
    if outParams.DoesExist("totalBytes") = false then outParams["totalBytes"] = m.getTotalBytes()
  else if requestName = "ping"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("bitrate") = false then outParams["bitrate"] = m.getBitrate()
    if outParams.DoesExist("throughput") = false then outParams["throughput"] = m.getThroughput()
    if outParams.DoesExist("totalBytes") = false then outParams["totalBytes"] = m.getTotalBytes()
    if outParams.DoesExist("playrate") = false then outParams["playrate"] = m.getPlayrate()
    if outParams.DoesExist("metrics") = false then outParams["metrics"] = m.getVideoMetrics()
  else if requestName = "bufferEnd"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    'Avoid sending a playhead of 0
    if outParams["playhead"] = 0
      outParams["playhead"] = 1
    end if
  else if requestName = "seekEnd"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
  else if requestName = "adStart" or requestName = "adInit"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("position") = false then outParams["position"] = m.getAdPosition()
    if outParams.DoesExist("adResource") = false then outParams["adResource"] = m.options["ad.resource"]
    if outParams.DoesExist("adCampaign") = false then outParams["adCampaign"] = m.options["ad.campaign"]
    if outParams.DoesExist("adTitle") = false then outParams["adTitle"] = m.options["ad.title"]
    if outParams.DoesExist("adCreativeId") = false then outParams["adCreativeId"] = m.options["ad.creativeId"]
    if outParams.DoesExist("adProvider") = false then outParams["adProvider"] = m.options["ad.provider"]
    if outParams.DoesExist("adProperties") = false then outParams["adProperties"] = m.options["ad.metadata"]
    if outParams.DoesExist("adDuration") = false then outParams["adDuration"] = m.getAdDuration()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
    if outParams.DoesExist("adNumber") = false then outParams["adNumber"] = m.getAdNumber()
    if outParams.DoesExist("adNumberInBreak") = false then outParams["adNumberInBreak"] = m.getAdNumberInBreak()
    if outParams.DoesExist("adnalyzerVersion") = false then outParams["adnalyzerVersion"] = "6.6.1 Roku Adnalyzer"
    'Extra params
    nextraparams = 10
    index = 1
    while (index <= nextraparams)
      optionKey = "ad.extraparam." + index.ToStr()
      paramKey = "extraparam" + index.ToStr()
      optionCustomDimensionKey = "ad.customDimension." + index.ToStr()
      paramValue = m.options[optionKey]
      if m.options[optionKey] = invalid then paramValue = m.options[optionCustomDimensionKey]
      if paramValue <> invalid
        if outParams.DoesExist(paramKey) = false then outParams[paramKey] = paramValue
      end if
      index = index + 1
    end while
  else if requestName = "adJoin"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("adNumber") = false then outParams["adNumber"] = m.getAdNumber()
    if outParams.DoesExist("adNumberInBreak") = false then outParams["adNumberInBreak"] = m.getAdNumberInBreak()
    if outParams.DoesExist("adDuration") = false then outParams["adDuration"] = m.getAdDuration()
  else if requestName = "adQuartile"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("adNumber") = false then outParams["adNumber"] = m.getAdNumber()
    if outParams.DoesExist("adNumberInBreak") = false then outParams["adNumberInBreak"] = m.getAdNumberInBreak()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
  else if requestName = "adPause"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
  else if requestName = "adResume"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
  else if requestName = "adStop"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
    if outParams.DoesExist("adNumber") = false then outParams["adNumber"] = m.getAdNumber()
    if outParams.DoesExist("adNumberInBreak") = false then outParams["adNumberInBreak"] = m.getAdNumberInBreak()
    if outParams.DoesExist("position") = false then outParams["position"] = m.getAdPosition()
    if outParams.DoesExist("adDuration") = false then outParams["adDuration"] = m.getAdDuration()
  else if requestName = "adError"
    if outParams.DoesExist("playhead") = false then outParams["playhead"] = m.getPlayhead()
    if outParams.DoesExist("position") = false then outParams["position"] = m.getAdPosition()
    if outParams.DoesExist("adResource") = false then outParams["adResource"] = m.options["ad.resource"]
    if outParams.DoesExist("adCampaign") = false then outParams["adCampaign"] = m.options["ad.campaign"]
    if outParams.DoesExist("adTitle") = false then outParams["adTitle"] = m.options["ad.title"]
    if outParams.DoesExist("adProperties") = false then outParams["adProperties"] = m.options["ad.metadata"]
    if outParams.DoesExist("adDuration") = false then outParams["adDuration"] = m.getAdDuration()
    if outParams.DoesExist("adPlayhead") = false then outParams["adPlayhead"] = m.getAdPlayhead()
    if outParams.DoesExist("adNumber") = false then outParams["adNumber"] = m.getAdNumber()
    if outParams.DoesExist("adNumberInBreak") = false then outParams["adNumberInBreak"] = m.getAdNumberInBreak()
  else if requestName = "adBreakStart"
    if outParams.DoesExist("givenAds") = false then outParams["givenAds"] = m.options["ad.givenAds"]
    if outParams.DoesExist("position") = false then outParams["position"] = m.getAdPosition()
    if outParams.DoesExist("expectedAds") = false
      if m.options["ad.expectedPattern"] <> invalid
        if type(m.options["ad.expectedPattern"]) = "roAssociativeArray"
          array = CreateObject("roArray", 0, true)
          if m.options["ad.expectedPattern"]["pre"] <> invalid
            if type(m.options["ad.expectedPattern"]["pre"]) = "roArray"
              array.Append(m.options["ad.expectedPattern"]["pre"])
            else
              YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
            end if
          end if
          if m.options["ad.expectedPattern"]["mid"] <> invalid
            if type(m.options["ad.expectedPattern"]["mid"]) = "roArray"
              array.Append(m.options["ad.expectedPattern"]["mid"])
            else
              YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
            end if
          end if
          if m.options["ad.expectedPattern"]["post"] <> invalid
            if type(m.options["ad.expectedPattern"]["post"]) = "roArray"
              array.Append(m.options["ad.expectedPattern"]["post"])
            else
              YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
            end if
          end if
          if array[outParams["breakNumber"]] <> invalid
            outParams["expectedAds"] = array[outParams["breakNumber"]]
          end if
        end if
      end if
    end if
  else if requestName = "adManifest"
    if outParams.DoesExist("givenBreaks") = false then outParams["givenBreaks"] = m.options["ad.givenBreaks"]
    if outParams.DoesExist("breaksTime") = false then outParams["breaksTime"] = m.options["ad.breaksTime"]
    if m.options["ad.expectedBreaks"] <> invalid
      outParams["expectedBreaks"] = m.options["ad.expectedBreaks"]
    else if m.options["ad.expectedPattern"] <> invalid
      if type(m.options["ad.expectedPattern"]) = "roAssociativeArray"
        length = 0
        if m.options["ad.expectedPattern"]["pre"] <> invalid
          if type(m.options["ad.expectedPattern"]["pre"]) = "roArray"
            length = length + m.options["ad.expectedPattern"]["pre"].Count()
          else
            YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
          end if
        end if
        if m.options["ad.expectedPattern"]["mid"] <> invalid
          if type(m.options["ad.expectedPattern"]["mid"]) = "roArray"
            length = length + m.options["ad.expectedPattern"]["mid"].Count()
          else
            YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
          end if
        end if
        if m.options["ad.expectedPattern"]["post"] <> invalid
          if type(m.options["ad.expectedPattern"]["post"]) = "roArray"
            length = length + m.options["ad.expectedPattern"]["post"].Count()
          else
            YouboraLog("Values inside ad.expectedPattern must be arrays", "InfoManager")
          end if
        end if
        outParams["expectedBreaks"] = length
      end if
    end if
    if outParams.DoesExist("expectedPattern") = false then outParams["expectedPattern"] = m.options["ad.expectedPattern"]
  else if requestName = "sessionStart"
    if outParams.DoesExist("navContext") = false then outParams["navContext"] = "RokuPlugin"
    if outParams.DoesExist("pluginName") = false then outParams["pluginName"] = m.plugin.getPluginName()
    if outParams.DoesExist("pluginVersion") = false then outParams["pluginVersion"] = m.plugin.getPluginVersion()
    if outParams.DoesExist("obfuscateIp") = false then outParams["obfuscateIp"] = m.options["user.obfuscateIp"]
    if outParams.DoesExist("deviceUUID") = false then outParams["deviceUUID"] = CreateObject("roDeviceInfo").GetChannelClientId()
    nextraparams = 20
    index = 1
    while (index <= nextraparams)
      optionKey = "extraparam." + index.ToStr()
      paramKey = "param" + index.ToStr()
      optionCustomDimensionKey = "content.customDimension" + index.ToStr()
      paramValue = getNestedValue(m.options, optionKey)
      if paramValue = invalid then paramValue = getNestedValue(m.options, optionCustomDimensionKey)
      if paramValue <> invalid
        if outParams.DoesExist(paramKey) = false then outParams[paramKey] = paramValue
      end if
      index = index + 1
    end while

  else if requestName = "sessionNav"
    if outParams.DoesExist("username") = false
      if m.options["user.name"] = invalid
        outParams["username"] = m.options["username"]
      else
        outParams["username"] = m.options["user.name"]
      end if
    end if
    if outParams.DoesExist("navContext") = false then outParams["navContext"] = "RokuPlugin"
    if outParams.DoesExist("route") = false then outParams["route"] = "Roku"
  else if requestName = "sessionBeat"
    ' ──────█▀▄─▄▀▄─▀█▀─█─█─▀─█▀▄─▄▀▀▀─────
    ' ──────█─█─█─█──█──█▀█─█─█─█─█─▀█─────
    ' ──────▀─▀──▀───▀──▀─▀─▀─▀─▀──▀▀──────
    ' ─────────────────────────────────────
    ' ───────────────▀█▀─▄▀▄───────────────
    ' ────────────────█──█─█───────────────
    ' ────────────────▀───▀────────────────
    ' ─────────────────────────────────────
    ' ─────█▀▀▄─█▀▀█───█──█─█▀▀─█▀▀█─█▀▀───
    ' ─────█──█─█──█───█▀▀█─█▀▀─█▄▄▀─█▀▀───
    ' ─────▀▀▀──▀▀▀▀───▀──▀─▀▀▀─▀─▀▀─▀▀▀───
    ' ─────────────────────────────────────
    ' ─────────▄███████████▄▄──────────────
    ' ──────▄██▀──────────▀▀██▄────────────
    ' ────▄█▀────────────────▀██───────────
    ' ──▄█▀────────────────────▀█▄─────────
    ' ─█▀──██──────────────██───▀██────────
    ' █▀──────────────────────────██───────
    ' █──███████████████████───────█───────
    ' █────────────────────────────█───────
    ' █────────────────────────────█───────
    ' █────────────────────────────█───────
    ' █────────────────────────────█───────
    ' █────────────────────────────█───────
    ' █▄───────────────────────────█───────
    ' ▀█▄─────────────────────────██───────
    ' ─▀█▄───────────────────────██────────
    ' ──▀█▄────────────────────▄█▀─────────
    ' ───▀█▄──────────────────██───────────
    ' ─────▀█▄──────────────▄█▀────────────
    ' ───────▀█▄▄▄──────▄▄▄███████▄▄───────
    ' ────────███████████████───▀██████▄───
    ' ─────▄███▀▀────────▀███▄──────█─███──
    ' ───▄███▄─────▄▄▄▄────███────▄▄████▀──
    ' ─▄███▓▓█─────█▓▓█───████████████▀────
    ' ─▀▀██▀▀▀▀▀▀▀▀▀▀███████████────█──────
    ' ────█─▄▄▄▄▄▄▄▄█▀█▓▓─────██────█──────
    ' ────█─█───────█─█─▓▓────██────█──────
    ' ────█▄█───────█▄█──▓▓▓▓▓███▄▄▄█──────
    ' ────────────────────────██──────────
    ' ────────────────────────██───▄███▄───
    ' ────────────────────────██─▄██▓▓▓██──
    ' ───────────────▄██████████─█▓▓▓█▓▓██▄
    ' ─────────────▄██▀───▀▀███──█▓▓▓██▓▓▓█
    ' ─▄███████▄──███───▄▄████───██▓▓████▓█
    ' ▄██▀──▀▀█████████████▀▀─────██▓▓▓▓███
    ' ██▀─────────██──────────────██▓██▓███
    ' ██──────────███──────────────█████─██
    ' ██───────────███──────────────█─██──█
    ' ██────────────██─────────────────█───
    ' ██─────────────██────────────────────
    ' ██─────────────███───────────────────
    ' ██──────────────███▄▄────────────────
    ' ███──────────────▀▀███───────────────
    ' ─███─────────────────────────────────
    ' ──███────────────────────────────────
  end if

  return outParams

end function

function InfoManager_getFromInnerAsocArray(dict as object, dictName as string, key as string)
  if dict <> invalid and dict.DoesExist(dictName) = true
    innerDict = dict[dictName]
    if innerDict <> invalid and type(innerDict) = "roAssociativeArray" and innerDict.DoesExist(key) = true
      value = innerDict[key]
      return value
    end if
  end if

  return invalid
end function
