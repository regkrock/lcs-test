Extension { #name : #FileReference }

{ #category : #'*Lcs-PharoExtensions' }
FileReference >> lcsAddFileContents: aReadStream to: anIndentedStream [
	anIndentedStream incrementNumberOfTabs.
	[ aReadStream atEnd ] whileFalse: [
		anIndentedStream newLine: aReadStream nextLine ].
	anIndentedStream decrementNumberOfTabs.
]

{ #category : #'*Lcs-PharoExtensions' }
FileReference >> lcsAddToGemstoneProjectStructureOn: anIndentedStream [
	anIndentedStream incrementNumberOfTabs.
	self children do: [ :each |
		each isDirectory 
			ifTrue: [
				anIndentedStream newFileDirectoryLine: each path basename.
				(#('rowan' 'src' 'specs' 'components' 'projects' ) includes: each path basename) ifTrue: [
					each lcsAddToGemstoneProjectStructureOn: anIndentedStream ] ]
			ifFalse: [
				anIndentedStream newLine: each path basename.
				((each path basename greaseEndsWith: '.ston') or: [ each path basename = 'properties.st' ]) 
					ifTrue: [ self lcsAddFileContents: each readStream to: anIndentedStream ] ] ].
	anIndentedStream decrementNumberOfTabs
]

{ #category : #'*Lcs-PharoExtensions' }
FileReference >> lcsGemstoneProjectStructure [
	| stream |
	stream := LcsIndentedWriteStream new.
	self path do: [ :each | 
		stream newFileDirectoryLine: each.
		stream incrementNumberOfTabs ].
	self entries do: [ :each |
		each isDirectory ifTrue: [ each lcsAddToGemstoneProjectStructureOn: stream ] ].
	^ stream contents
]
