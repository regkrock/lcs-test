Class {
	#name : #LcsDomainCollection,
	#superclass : #LcsDomainObject,
	#instVars : [
		'collection'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot definition' }
LcsDomainCollection class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentityCollectionSlot new
]

{ #category : #collection }
LcsDomainCollection >> add: anObject [
	^ self collection add: anObject
]

{ #category : #collection }
LcsDomainCollection >> collect: aBlock [
	^ self collection collect: aBlock
]

{ #category : #accessing }
LcsDomainCollection >> collection [
	^ self getValueOfSlotNamed: 'collection'
]

{ #category : #accessing }
LcsDomainCollection >> collection: aCollection [
	self setValueOfSlotNamed: 'collection' to: aCollection
]

{ #category : #configuration }
LcsDomainCollection >> collectionClass [
	^ self class collectionClass
]

{ #category : #queries }
LcsDomainCollection >> defaultInstance [
	<todo: 'the null object needs to replace this?'>
	^nil
]

{ #category : #collection }
LcsDomainCollection >> detect: aBlock [
	^ self collection detect: aBlock
]

{ #category : #collection }
LcsDomainCollection >> detect: aBlock ifNone: anIfNoneBlock [
	^ self collection detect: aBlock ifNone: anIfNoneBlock
]

{ #category : #collection }
LcsDomainCollection >> do: aBlock [
	^ self collection do: aBlock
]

{ #category : #search }
LcsDomainCollection >> findWithKey: anObject [
	^ self collection detect: [ :each | each key = anObject ] ifNone: [  ]
]

{ #category : #'gt view' }
LcsDomainCollection >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Items' translated;
		priority: 0.5;
		object: [ self collection ];
		view: #gtItemsFor:
]

{ #category : #testing }
LcsDomainCollection >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LcsDomainCollection >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #collection }
LcsDomainCollection >> includes: anObject [
	^ self collection includes: anObject
]

{ #category : #initialization }
LcsDomainCollection >> initialize [
	super initialize
]

{ #category : #collection }
LcsDomainCollection >> inject: anObject into: aBlock [
	^ self collection inject: anObject into: aBlock
]

{ #category : #collection }
LcsDomainCollection >> reject: aBlock [
	^ self collection reject: aBlock
]

{ #category : #collection }
LcsDomainCollection >> remove: anObject [
	^ self collection remove: anObject
]

{ #category : #collection }
LcsDomainCollection >> remove: anObject ifAbsent: aBlock [
	^ self collection remove: anObject ifAbsent: [ ]
]

{ #category : #collection }
LcsDomainCollection >> removeAll [
	^ self collection removeAll
]

{ #category : #collection }
LcsDomainCollection >> select: aBlock [
	^ self collection select: aBlock
]

{ #category : #collection }
LcsDomainCollection >> size [
	^ self collection size
]
