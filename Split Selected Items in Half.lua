reaper.Undo_BeginBlock2(0)

selected_item_count = reaper.CountSelectedMediaItems(0)
items = {}

for i=0, selected_item_count do
  items[i] = reaper.GetSelectedMediaItem(0, i)
end

for i, item in pairs(items) do
  pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  reaper.SplitMediaItem(item, (pos+len/2))
  reaper.UpdateItemInProject(item)
end

reaper.Undo_EndBlock2(0, "Split", 4)
