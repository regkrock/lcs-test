Class {
	#name : #LcsCollection,
	#superclass : #LcsObject,
	#instVars : [
		'collection',
		'parent'
	],
	#category : #LcsBase
}

{ #category : #defaults }
LcsCollection class >> collectionClass [
	self subclassResponsibility
]

{ #category : #'instance creation' }
LcsCollection class >> newOn: anOjbect [
	^ self new
		initializeOn: anOjbect;
		yourself
]

{ #category : #collection }
LcsCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : #collection }
LcsCollection >> collect: aBlock [
	^ self collection collect: aBlock
]

{ #category : #accessing }
LcsCollection >> collection [
	^ collection
]

{ #category : #accessing }
LcsCollection >> collection: anObject [
	collection := anObject
]

{ #category : #defaults }
LcsCollection >> collectionClass [
	^ self class collectionClass
]

{ #category : #collection }
LcsCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : #collection }
LcsCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : #collection }
LcsCollection >> do: aBlock [
	self collection do: aBlock
]

{ #category : #testing }
LcsCollection >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LcsCollection >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #collection }
LcsCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : #inititialize }
LcsCollection >> initialize [ 

	super initialize.
	self collection: self collectionClass new
]

{ #category : #inititialize }
LcsCollection >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #collection }
LcsCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : #testing }
LcsCollection >> isEmpty [
	^self collection isEmpty
]

{ #category : #testing }
LcsCollection >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #testing }
LcsCollection >> notEmpty [
	^ self isNotEmpty
]

{ #category : #accessing }
LcsCollection >> parent [
	^ parent
]

{ #category : #accessing }
LcsCollection >> parent: anObject [
	parent := anObject
]

{ #category : #collection }
LcsCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : #collection }
LcsCollection >> remove: anObject [
	^ self collection remove: anObject
]

{ #category : #collection }
LcsCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: aBlock
]

{ #category : #collection }
LcsCollection >> removeAll [
	^ self collection removeAll
]

{ #category : #collection }
LcsCollection >> select: aBlock [
	^ self collection select: aBlock
]

{ #category : #collection }
LcsCollection >> size [
	^ self collection size
]
