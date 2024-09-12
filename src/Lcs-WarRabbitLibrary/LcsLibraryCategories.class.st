Class {
	#name : #LcsLibraryCategories,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #query }
LcsLibraryCategories >> libraryCategoryFor: aString [
	^ self collection
		detect: [ :each | each categoryName = aString ]
		ifNone: [ LcsLibraryCategory new
				categoryName: aString;
				yourself ]
]
