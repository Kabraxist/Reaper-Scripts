if reaper.GetSelectedMediaItem(0, 0) ~= nil then
  selectedTrack = reaper.GetSelectedTrack(0,0)
  originalTrackName = reaper.GetTrackState(selectedTrack)
  newName = reaper.GetTakeName(reaper.GetTake(reaper.GetSelectedMediaItem(0,0),0))
  
  --Get name from region if possible
  m, r = reaper.GetLastMarkerAndCurRegion(0, reaper.GetCursorPosition())
  if r ~= -1 then
    retval, isrgn, pos, rgnend, rgnName, markrgnindexnumber = reaper.EnumProjectMarkers(r)
    if isrgn then
      newName = rgnName
    end
  end
  
  inputBool, newName = reaper.GetUserInputs("New Subproject Name?", 1, "Name:extrawidth=200", newName)
  
  --Rename track, create subproject, unrename track
  if inputBool then
    reaper.GetSetMediaTrackInfo_String(selectedTrack, "P_NAME", newName, true)
    reaper.Main_OnCommandEx(41996, 0, 0) 
    reaper.GetSetMediaTrackInfo_String(selectedTrack, "P_NAME", originalTrackName, true)
  end
end

