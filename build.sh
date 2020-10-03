#
# The command operates in a directory containing the directories
# each containing the content of the repo corresponding to a given
# snapshot. The name of the parent directory is that of the resulting
# git repository. The name of each directory is that of the tag
# associated snapshot. Thay are recorded in lexicographic order
# in the repo.
#

#!/bin/bash
set -e

# Set the repo name to the name of this directory
repo=`basename $PWD`
echo $repo

# Create the list of tags from the file names
taglist=""
for d in $repo-*
do
	taglist="$taglist ${d#$repo-}"
done
echo -e "Tags: " $taglist "\n"

# Check if repo exists, ask for authorization to remove
if [ -e $repo ]
then
	echo "**** WARNING: The repository already exists!"
	read -p "Should I delete it (Ny)? "
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
		exit 1
	fi
	rm -rf $repo
fi

# Create new directory and inistialize as git repo
mkdir $repo
cd $repo
git init

# Register all snapshots as tagged commits with comments
for tag in $taglist
do
 	rsync -ad ../$repo-$tag/* ./         # sync repo with step snapshot
	cat ../README-$tag.md >> README.md   # attach new step readme
	comment=`grep $tag ../commit.lst`    # grab tag comment from file
	git add *							 # update index
	git commit -am "$comment"            # generate new commit with comment
	git tag -a $tag -m "${comment#$tag}" # apply tag with comment
done

echo -e "\n** The new repo has been generated **\n\
\n\
   Now:\n\
   - remove the old github repo,\n\
   - create a new one with same name,\n\
   - set new repo as remote origin,\n\
   - push the repo on remote origin,\n\
   - push the tags on remote origin\n\n"
