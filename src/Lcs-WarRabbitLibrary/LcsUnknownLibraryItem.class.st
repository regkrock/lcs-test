Class {
	#name : #LcsUnknownLibraryItem,
	#superclass : #LcsLibraryItem,
	#instVars : [
		'parts',
		'originalLine'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'instace creation' }
LcsUnknownLibraryItem class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #initialize }
LcsUnknownLibraryItem >> initialize [
	super initialize.
	self parts: OrderedCollection new
]

{ #category : #initialize }
LcsUnknownLibraryItem >> initializeOn: aString [ 

	self originalLine: aString.
	(aString at: 1) = Character tab
		ifTrue:[self parts add: String new].
	self parts addAll: (aString substrings: {Character tab})
]

{ #category : #accessing }
LcsUnknownLibraryItem >> initializeOn: aString parts: protoItemParts [ 
	self 
		originalLine: aString;
		parts: protoItemParts
]

{ #category : #accessing }
LcsUnknownLibraryItem >> originalLine [
	^ originalLine
]

{ #category : #accessing }
LcsUnknownLibraryItem >> originalLine: anObject [
	originalLine := anObject
]

{ #category : #accessing }
LcsUnknownLibraryItem >> parts [
	^ parts
]

{ #category : #initialize }
LcsUnknownLibraryItem >> parts: anObject [ 
	parts := anObject
]
