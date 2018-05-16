# benderlabs
Scripts used in my Windows/Ubuntu servers

MoviesIntoFolders.ps - Take a collection of movie files, all in one folder, and separate them into subfolders based on the name of the file. 

CreateUserFolderSetPermissions.ps1 - Check for the existance of a user in Active Directory. If the exist, create a 'home' folder for them on my file server, and set the permissions on their folder so only they have access to it.

Transcode.ps1 - Use ffmpeg to re-encode video folders. Takes an input folder, an output folder, the desired audio and video codecs, and container that the user wishes the video to be encoded to.

TODO: Have the script show a list of available codecs, rather than making the user look them up (e.g. to get video in h264, you have to enter libx264, since thats what ffmpeg expects)
