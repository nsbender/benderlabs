$sourcefolder = Read-Host "Enter source folder"
$targetfolder = Read-Host "Enter destination folder"
$targetaudio = if(($result = Read-Host "Enter the desired audio encoding (enter to keep current)") -eq ''){"copy"}else{$result}
$targetvideo = if(($result = Read-Host "Enter the desired video encoding (enter to keep current)") -eq ''){"copy"}else{$result}
$targetext = if(($result = Read-Host "Enter the desired container (enter to keep current)") -eq ''){""}else{$result} 
Write-Host $targetext

$filelist = Get-ChildItem $sourcefolder -File
 
$num = $filelist | measure
$filecount = $num.count
 
$i = 0;
ForEach ($file in $filelist)
{
    $i++;
    $oldfile = $sourcefolder + "\" + $file.BaseName + $file.Extension;
    $newfile = $targetfolder + "\" + $file.BaseName + $(If($targetext -eq ''){"." + $file.Extension} Else {"$targetext"});
    Write-Host $newfile
      
    $progress = ($i / $filecount) * 100
    $progress = [Math]::Round($progress,2)
 
   
    Write-Host -------------------------------------------------------------------------------
    Write-Host FFmpeg Audio Batch Encoding
    Write-Host "Processing - $oldfile"
    Write-Host "File $i of $filecount - $progress%"
    Write-Host -------------------------------------------------------------------------------
     
    Start-Process "C:\Program Files\FFmpeg\ffmpeg.exe" -ArgumentList "-i `"$oldfile`" -c:a `"$targetaudio`" -strict experimental -b:a 192k -c:v `"$targetvideo`" `"$newfile`" -loglevel info" -Wait -NoNewWindow
    
}

#F:\Shares\Media\Television\Westworld\Season 01
#libx264 -preset slow -crf 17