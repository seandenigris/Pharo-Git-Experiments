as yet unclassified
allFrom: file
	"I parse a 'fuller' git log of commits e.g. `git log A'..HEAD_SHA1 --pretty=fuller > ../export.txt` into domain objects"
	| lines str commit authorLine message commits |
	lines := file contents lines.
	str := lines readStream.
	commits := OrderedCollection
		streamContents: [ :col | 
			[ str atEnd not ]
				whileTrue: [ commit := GitCommit new.
					col nextPut: commit.
					commit sha1: (commit copy: str next after: 'commit').
					((authorLine := str next) beginsWith: 'Merge:')
						ifTrue: [ commit merge: (commit copy: authorLine after: 'Merge:').
							authorLine := str next ].
					commit author: (commit copy: authorLine after: 'Author:').
					commit authorDate: (commit copy: str next after: 'AuthorDate:').
					commit committer: (commit copy: str next after: 'Commit:').
					commit commitDate: (commit copy: str next after: 'CommitDate:').
					str next.
					message := String
						streamContents: [ :cmStr | 
							[ str atEnd or: [ str peek beginsWith: 'commit ' ] ]
								whileFalse: [ cmStr
										nextPutAll: str next trimBoth;
										lf ] ].
					message := message trimRight: [ :c | c = Character lf or: [ c = Character cr ] ].
					commit commitMessage: message ] ].
	^ commits reverse.