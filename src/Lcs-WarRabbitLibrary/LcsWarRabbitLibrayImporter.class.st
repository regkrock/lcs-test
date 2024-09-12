Class {
	#name : #LcsWarRabbitLibrayImporter,
	#superclass : #LcsObject,
	#instVars : [
		'library',
		'currentCategory',
		'currentAuthors',
		'importedLines',
		'items',
		'protoItemParts'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsWarRabbitLibrayImporter class >> newOn: aLibrary [ 
	^ self new
		initializeOn: aLibrary;
		yourself
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> candidateLibraryComponent: aString [
	^ self isLibraryCategoryCandidate
		ifTrue: [ self libraryCategoryCandidate ]
		ifFalse: [ (self libraryItemFor: aString)
					libraryCategory: self currentCategory;
					yourself ]
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentAuthors [
	^ currentAuthors
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentAuthors: anObject [
	currentAuthors := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> currentLine [
	^ self importedLines last
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importLine: aString [
	self importedLines add: aString.
	self protoItemParts: (aString substrings: {Character tab}).
	self items add: (self candidateLibraryComponent: aString)
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importedLines [
	^ importedLines
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> importedLines: anObject [
	importedLines := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> initialize [
	super initialize.
	self importedLines: OrderedCollection new.
	self items:OrderedCollection new
]

{ #category : #initialize }
LcsWarRabbitLibrayImporter >> initializeOn: aLibrary [ 
	self library: aLibrary
]

{ #category : #testing }
LcsWarRabbitLibrayImporter >> isLibraryCategoryCandidate [
	^ self protoItemParts size = 1
		and: [ self protoItemParts first allSatisfy: [ :each | each isCharacter ] ]
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> items [
	^ items
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> items: aCollection [
	items := aCollection
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> library [
	^ library
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> library: anObject [
	library := anObject
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> libraryCategoryCandidate [
	self currentCategory: (self currentSystem libraryCategoryFor: self protoItemParts first).
	^self currentCategory
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> libraryItemFor: aString [
	((self protoItemParts includes: 'pb') | (self protoItemParts includes: 'hc') | (self protoItemParts includes: 'hc+dj'))
		ifTrue: [ ^ LcsBook newOn: aString parts: self protoItemParts ]. 
	^ LcsUnknownLibraryItem newOn: aString parts: self protoItemParts
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> protoItemParts [
	^ protoItemParts
]

{ #category : #accessing }
LcsWarRabbitLibrayImporter >> protoItemParts: anObject [
	protoItemParts := anObject
]
