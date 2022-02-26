#!/bin/bash
# Move Local Home Folders to OneDrive

sudo
ODFolder="OneDrive"
KnownFolders=( 
    "Desktop"
    "Documents"
    #"Downloads"
)

for WorkingFolder in "${KnownFolders[@]}"
do
	# Unlock existing folder
	echo unlocking "/Users/$USER/$WorkingFolder"	
	sudo chflags -h noschg "/Users/$USER/$WorkingFolder"

	# Copy all files from existing folder to OneDrive folder
	echo "Copying $WorkingFolder to /Users/$USER/$ODFolder/$WorkingFolder"
	mkdir -p "/Users/$USER/$ODFolder"
	rsync -havux ~/$WorkingFolder "/Users/$USER/$ODFolder/$WorkingFolder"
	
	# Remove existing folder
	sudo rm -rf ~/$WorkingFolder
	
	# Redirect folder to OneDrive
	echo "Redirecting $WorkingFolder to /Users/$USER/$ODFolder/$WorkingFolder"
	ln -s "/Users/$USER/$ODFolder/$WorkingFolder" ~/$WorkingFolder
	
	# Lock folder
	echo locking "/Users/$USER/$WorkingFolder"
	sudo chflags -h schg "/Users/$USER/$WorkingFolder"
done