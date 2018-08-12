I semi-automate the process of rebuilding the branch of a 
fork (https://github.com/seandenigris/Magritte3) on top of a branch from 
the upstream, based on the last shared (content) commit (e.g. upstream 51f648b vs 
fork 47df0a5, both titled "[FIX]: Respect action shortcuts…"), even though the two remotes technically have no commits in common (i.e., shared sha1's). This need and possible approaches were discussed on [Pharo-Users](http://forum.world.st/ANN-Magritte-moved-to-github-tp5082723.html).

The process turned out to be:
1. Create new branch from upstream master and revert to last content-equal commit (call it A) on which to replay fork changes. 
2. Create git log of commits from fork's first divergent commit (A') to HEAD, via git log `A'..HEAD_SHA1 --pretty=fuller > ../export.txt` 
3. For each commit in log: 
  a. `git mv source repository` - temporarily rename "source" (code 
subfolder from upstream) to "repository" (subfolder from fork) to ease 
merging 
  b. `git cherry-pick -n $sha1` (where sha1 = e.g. B') - replay changes 
without committing 
  c. `git rm -f */methodProperties.json` and then `git rm -f */version` - 
remove metadata, since upstream commits are metadata-less 
  d. `git reset HEAD` - reset git so it forgets about steps a and c, which 
are just to conform the fork commits to upstream, but leaves the actual 
changes in place 
  e. `mv repository/ source` 
  f. `git add -A` - inform git about all changes now that everything is how 
we want it 
  g. `git commit --date="Sun Mar 25 22:57:40 2018 -0400" -m "Fix #17…" 
--author="Whom Ever <[hidden email]>"`- commit preserving 
original author and author date 

I parse the log from #2 above into domain objects (via `#allFrom:) and create and execute the commands in #3 (via `#cherryPick`).