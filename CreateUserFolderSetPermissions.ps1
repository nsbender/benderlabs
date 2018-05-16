$username =  Read-Host -Prompt 'Username of user needing folder'
#Make sure that user exists
if (dsquery user -samid $username){

    $user = 'Benderlabs\' + "$username"

    $path = Join-Path '\\files1\users$\' "$username"
    If(!(test-path $path))
    {
          $newfolder = New-Item -ItemType Directory -Force -Path $path
          Write-Host "Folder Created"
    }
    else {
        Write-Host "Folder exists. Reset Permissions?"
        $fixpreference = Read-Host -Prompt "Y/N?"
        Switch ($fixpreference) { 
            Y {} 
            N {Write-Host "No, Skip Permission Fix"; exit} 
            Default {Write-Host "Default, Skip Permission Fix"; exit} 
     } 
    }

    $Acl = Get-Acl $path

    $ntaccount=[System.Security.Principal.NTAccount]$user
    $Ace = New-Object System.Security.AccessControl.FileSystemAccessRule( $ntaccount,@(
        "ListDirectory", 
        "ReadData",
        "ReadPermissions",
        "WriteData", 
        "CreateFiles", 
        "CreateDirectories", 
        "AppendData",
        "ReadExtendedAttributes", 
        "WriteExtendedAttributes", 
        "Traverse",
        "ExecuteFile",
        "DeleteSubdirectoriesAndFiles", 
        "ReadAttributes",
        "WriteAttributes", 
        "Write",
        "Synchronize"
    ), "ContainerInherit, ObjectInherit", "None", "Allow")

    $Acl.AddAccessRule($Ace)
    Set-Acl $path $Acl
    Write-Host "Permissions Set"

}
else {Write-Error "User not found"; pause}

#The possible values for Rights are 
# ListDirectory, ReadData, WriteData 
# CreateFiles, CreateDirectories, AppendData 
# ReadExtendedAttributes, WriteExtendedAttributes, Traverse
# ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes 
# WriteAttributes, Write, Delete 
# ReadPermissions, Read, ReadAndExecute 
# Modify, ChangePermissions, TakeOwnership
# Synchronize, FullControl
