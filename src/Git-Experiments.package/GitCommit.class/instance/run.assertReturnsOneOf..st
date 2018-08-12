private
run: aString assertReturnsOneOf: aCollection
	| returnCode |
	returnCode := LibC system: aString.
	(aCollection includes: returnCode) ifFalse: [ self notify: aString, ' failed with ', returnCode asString ]