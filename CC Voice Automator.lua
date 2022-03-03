selectedItem = reaper.GetSelectedMediaItem(0, 0)
selectedTrack = reaper.GetMediaItem_Track(selectedItem)
newItems = {}
newItems[0] = selectedItem
pitches = { 0.0, 0.0, 4.0, 4.0 }

itemLength = reaper.GetMediaItemInfo_Value(selectedItem, "D_LENGTH")
reaper.SetMediaItemInfo_Value(selectedItem, "D_FADEINLEN", itemLength/10)
reaper.SetMediaItemInfo_Value( selectedItem, "D_FADEOUTLEN", itemLength/1.2)
reaper.SetMediaItemInfo_Value(selectedItem, "C_FADEOUTSHAPE", 2)

reaper.ApplyNudge(0, 0, 5, 2, 1, false, 19)

--Get items from current track
i = 0
while i <= reaper.GetTrackNumMediaItems(selectedTrack) do
  --reaper.SetMediaItemSelected(reaper.GetTrackMediaItem(selectedTrack, i), true)
  newItems[i] = reaper.GetTrackMediaItem(selectedTrack, i)
  i = i + 1
end
reaper.SelectAllMediaItems(0, false)

--Random time offset
for id, item in ipairs(newItems) do
  local randomOffset = math.random(2048)
  reaper.SetMediaItemSelected(item, true)
  reaper.ApplyNudge(0, 0, 4, 0, randomOffset, false, 0)
end
reaper.SelectAllMediaItems(0, false)

--Apply Scale and Normalize
for id, item in ipairs(newItems) do
  reaper.SetMediaItemSelected(item, true)
  reaper.SetMediaItemTakeInfo_Value(reaper.GetMediaItemTake(item, 0), "D_PITCH", pitches[(id%4)+1])
end
