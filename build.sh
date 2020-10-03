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

repo=`basename $PWD`
echo $repo

taglist=""

# Create the list of tags
for d in $repo-*
do
	taglist="$taglist ${d#$repo-}"
done

echo -n "Tags: "
echo $taglist
echo

if [ -e $repo ]
then
	echo "**** ERROR: The repository already exists: cannot overwrite"
	exit 1
fi

mkdir $repo
cd $repo
git init

for tag in $taglist
do
	rsync -ad ../$repo-$tag/* ./
	comment=`grep $tag ../commit.lst`
	git add *
	git commit -am "$comment"
	git tag -a $tag -m "${comment#$tag}"
done
