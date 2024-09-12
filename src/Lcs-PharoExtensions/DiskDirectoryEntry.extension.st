Extension { #name : #DiskDirectoryEntry }

{ #category : #'*Lcs-PharoExtensions' }
DiskDirectoryEntry >> lcsAddToGemstoneProjectStructureOn: anIndentedStream [
	anIndentedStream incrementNumberOfTabs.
	anIndentedStream newFileDirectoryLine: self basename .
	self reference lcsAddToGemstoneProjectStructureOn: anIndentedStream.
	anIndentedStream decrementNumberOfTabs.
]
