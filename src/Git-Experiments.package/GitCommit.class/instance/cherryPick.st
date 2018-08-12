actions
cherryPick
	"Execute the commands described in my class comment to replay changes on top of a commit with the following characteristics:
		- not an ancestor of this commit
		- content-equivalent, except
		- has a different code sub-folder"
		
	self assert: self merge isNil. "Not sure how/if to handle merge commits"
	self run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git mv source repository'.
	self assert: (self rootFolder / 'repository') exists.
	self assert: (self rootFolder / 'source') exists not.
	
	self 
		run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git cherry-pick -n ', self sha1 
		assertReturnsOneOf: self cherryPickReturnCodes.
		
	self 
		run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git rm -f */methodProperties.json'
		assertReturnsOneOf: self rmReturnCodes.
	self 
		run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git rm -f */version'
		assertReturnsOneOf: self rmReturnCodes.
		
	self run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git reset HEAD'.
	
	self run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; mv repository/ source'.
	self assert: (self rootFolder / 'repository') exists not.
	self assert: (self rootFolder / 'source') exists.
	
	(self rootFolder / '.DS_Store') ensureDelete.
	
	self run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; git add -A'.
	
	self run: 'cd "/Users/sean/Dynabook/Repositories/magritte"; ', self commitCommand.