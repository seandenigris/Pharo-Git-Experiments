accessing
commitCommand
	| template |
	template := 'git commit --date="{authorDate}" -m "{commitMessage}" --author="{author}"'.
	^ template format: { 
			#commitDate -> self commitDate.
			#authorDate -> self authorDate.
			#commitMessage -> self escapedCommitMessage.
			#author -> self author } asDictionary
	