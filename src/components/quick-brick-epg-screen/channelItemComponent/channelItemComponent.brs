
function init()
  initfunctionview()
end function

function initfunctionview()
  m.top.channelInfoBackgroundBitmapUri = "pkg:/images/TimeGridBackground.9.png"
  m.photoRectangle = m.top.findNode("photoRectangle")
  m.channelPoster = m.top.findNode("channelPoster")
  m.programFrame = m.top.findNode("programFrame")
end function

function updateMaskSize()
  channelGuideSettings = mioc.getInstance("channelGuideItem").channelGuideSettings

  yPadding = channelGuideSettings.channelPaddingTop
  xPadding = channelGuideSettings.channelPaddingLeft - channelGuideSettings.channelPaddingRight

  m.photoRectangle.maskSize = [m.top.width - 120, m.top.height - 10]
  m.programFrame.width = m.top.width - 120
  m.programFrame.height = m.top.height - 10

  aspectRatio = channelGuideSettings.channelAssetAspectRatio
  if aspectRatio = "other"
    aspectRatio = channelGuideSettings.channelCustomAssetAspectRatio
  end if
  ratioValue = aspectRatio.split("x")
  m.channelPoster.height = channelGuideSettings.channelAssetHeight
  channelAssetWidth = m.channelPoster.height * ratioValue[0].toInt() / ratioValue[1].toInt()
  m.channelPoster.width = channelAssetWidth
  xPosition = (channelAssetWidth / 2) + xPadding
  m.photoRectangle.translation = [xPosition, yPadding]
end function

function OnContentChangeForChannel()
  if m.top.content <> invalid
    content = m.top.content
    m.channelPoster.uri = content.HDSMALLICONURL
    uri = "pkg:/images/fhd/SearchMenu/frameForRow.png"
    blendColor = "0x000000"
    ' if content.isFocused = true
    '     uri = "pkg:/images/fhd/SearchMenu/frameForRowSelected.png"
    '     blendColor = "0xFFFFFF"
    ' end if
    m.programFrame.uri = uri
    m.programFrame.blendColor = blendColor
  end if
end function

function onChannelBackground()
end function

function onGridHasFocusChange(event as object)
  changedFocus()
end function


function changedFocus()

end function

