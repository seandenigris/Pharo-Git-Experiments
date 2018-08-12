testing
matchesPorted: rhs

	^ (self author copyUpTo: $<) = (rhs author copyUpTo: $<) and: [ self authorDate = rhs authorDate and: [ (self committer copyUpTo: $<) = (rhs committer copyUpTo: $<) and: [ self commitMessage = rhs commitMessage ] ] ]