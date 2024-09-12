Class {
	#name : #LcsLibrayImporter,
	#superclass : #LcsObject,
	#instVars : [
		'library',
		'currentCategory',
		'currentAuthors',
		'importedLines'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsLibrayImporter >> currentAuthors [
	^ currentAuthors
]

{ #category : #accessing }
LcsLibrayImporter >> currentAuthors: anObject [
	currentAuthors := anObject
]

{ #category : #accessing }
LcsLibrayImporter >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
LcsLibrayImporter >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #accessing }
LcsLibrayImporter >> importedLines [
	^ importedLines
]

{ #category : #accessing }
LcsLibrayImporter >> importedLines: anObject [
	importedLines := anObject
]

{ #category : #accessing }
LcsLibrayImporter >> initialize [
	super initialize.
	self importedLines: OrderedCollection new
]

{ #category : #accessing }
LcsLibrayImporter >> library [
	^ library
]

{ #category : #accessing }
LcsLibrayImporter >> library: anObject [
	library := anObject
]
