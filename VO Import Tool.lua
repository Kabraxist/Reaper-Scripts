-- TODO
-- Last dir only updates on close. Find a better solution. get_config_var_string
-- Don't block Reaper
-- Check Ultraschall API for CSV parse
-- Check files really existw

import_table = {}
import_confirm = 0

function parseCSVLine(l)
  t = {}
  for item in l:gmatch('([^,]+)') do
    table.insert(t, item)
  end
  return t
end

function openCsvFile()
  --get last dir
  bool, last_dir =  reaper.BR_Win32_GetPrivateProfileString("reaper_explorer", "lastdir", "", reaper.get_ini_file())
  
  --open file, get folder path
  csv_exists, file_path = reaper.GetUserFileNameForRead(last_dir.."\\", "Pick CSV file", "csv")
  folder_path = file_path:match("(.*".."\\"..")") 
  
  if csv_exists then
    f = io.open(file_path, "r") 
    for line in f:lines() do
      tuple = parseCSVLine(line)
      tuple[2] = folder_path..tuple[2]
      table.insert(import_table, tuple)
    end 
    f:close()
    import_confirm = reaper.ShowMessageBox("CSV file seems OK. Do you want to import files?", "CSV Found", 4)
  else 
    reaper.ShowMessageBox("No file selected!", "Alert", 0)
  end 
end

function importFiles() 
  if import_confirm == 6 then
    --Add a new track
    reaper.InsertTrackAtIndex(0, false) 
    track = reaper.GetTrack(0, 0)
    reaper.UpdateArrange()
    reaper.SetTrackSelected(track, true)
    
    --Add items
    for i, tuple in pairs(import_table) do 
      item_id = reaper.InsertMedia(tuple[2], 0)
      item = reaper.GetSelectedMediaItem(0, 0)
      take = reaper.GetTake(item, 0)
      reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", tuple[1], true)
      reaper.MoveEditCursor(6, false)
      reaper.SelectAllMediaItems(0, false)
      reaper.UpdateTimeline()
    end
    
  end
end

openCsvFile()
importFiles()
