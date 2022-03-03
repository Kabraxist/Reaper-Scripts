track_count = reaper.CountTracks(0)

reaper.Undo_BeginBlock()

for i=0, track_count-1,1 do
  track = reaper.GetTrack(0, i)
  reaper.SetTrackSelected(track, false)
  
  depth = reaper.GetTrackDepth(track)
  
  if depth ~= 0 then
    reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 0)
    reaper.SetMediaTrackInfo_Value(track, "B_SHOWINTCP", 0)
  end 
end

reaper.Undo_EndBlock("Undo Expose Root Tracks", 0)

reaper.TrackList_AdjustWindows(true)
