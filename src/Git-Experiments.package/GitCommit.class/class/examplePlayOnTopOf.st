as yet unclassified
examplePlayOnTopOf
	| source target sourceCommits ported commits og |
	source := FileLocator home / 'export.txt'.
	target := FileLocator home / 'export_target.txt'.
	sourceCommits := (GitCommit allFrom: source) select: [ :e | e merge isNil ].
	sourceCommits do: [ :e | e cherryPick ].
	ported := GitCommit allFrom: target.
	commits doWithIndex: [ :e :i | 
		og := ported at: i.
		(og matchesPorted: e) ifFalse: [ 
			e inspect.
			og inspect.
			Halt now ] ]