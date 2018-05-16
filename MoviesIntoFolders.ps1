$basefolder = "F:\Shares\Media\Movies\"

Get-ChildItem -File -Path $basefolder | 
    ForEach-Object {
        Write-Host $_.BaseName
        If (!(Test-Path -Path ($basefolder + $_.BaseName))){
            $dir = New-Item -Type Directory -Path $basefolder -Name $_.BaseName
        }else{
            $dir = "F:\Shares\Media\Movies\$_.BaseName"
        }
        Move-Item $_.FullName -Destination ($basefolder + $_.BaseName + "\")
    }
