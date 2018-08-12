accessing
escapedCommitMessage
	| safer |
	safer := self commitMessage copyReplaceAll: '"' with: '\"'.
	^ safer copyReplaceAll: '`' with: '\`'.