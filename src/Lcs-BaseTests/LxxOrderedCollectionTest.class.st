Class {
	#name : #LxxOrderedCollectionTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #tests }
LxxOrderedCollectionTest >> testAdd [
	| anLxxCollection addedObject |
	anLxxCollection := LxxOrderedCollection new.
	self assert: anLxxCollection isEmpty.
	self deny: anLxxCollection isNotEmpty.
	self assert: anLxxCollection hasNoElements.
	self deny: anLxxCollection hasElements.
	
	addedObject := anLxxCollection add: 1.
	
	self assert: addedObject equals: 1.
	self deny: anLxxCollection isEmpty.
	self assert: anLxxCollection isNotEmpty.
	self deny: anLxxCollection hasNoElements.
	self assert: anLxxCollection hasElements.

]

{ #category : #tests }
LxxOrderedCollectionTest >> testCollect [
	| anLxxCollection result |
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection collect: [:each | each + 1 ].
	self assert: (result at: 1) equals: 2.
	self assert: (result at: 2) equals: 3.
	
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testCreation [
	| anLxxCollection |
	anLxxCollection := LxxOrderedCollection new.
	self assert: anLxxCollection collection class equals: OrderedCollection
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testDo [
	| anLxxCollection result |
	result := OrderedCollection new.
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	anLxxCollection do: [:each | result add: each + 1 ].
	self assert: (result at: 1) equals: 2.
	self assert: (result at: 2) equals: 3.
	
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testIncludes [
	| anLxxCollection result |
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection select: [:each | each > 1 ].
	self assert: (anLxxCollection includes: 1).
	self deny: (anLxxCollection includes: 10).
	
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testInjectInto [
	| anLxxCollection result |
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection inject: 0 into: [:total :each | total + each ].
	self assert: result equals: 3.
	
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testReject [
	| anLxxCollection result |
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection reject: [:each | each > 1 ].
	self assert: result size equals: 1.
	self assert: (result at: 1) equals: 1.
	
]

{ #category : #accessing }
LxxOrderedCollectionTest >> testRemove [
	| anLxxCollection addedObject removedOjbect |
	anLxxCollection := LxxOrderedCollection new.
	addedObject := anLxxCollection add: 1.
	
	removedOjbect := anLxxCollection remove: 1.

	self assert: addedObject equals: 1.
	self assert: removedOjbect equals: 1.

	self assert: anLxxCollection isEmpty.
	self deny: anLxxCollection isNotEmpty.
	self assert: anLxxCollection hasNoElements.
	self deny: anLxxCollection hasElements.
	
	self assert: (anLxxCollection remove: 1 ifAbsent: [ nil ]) isNil.
	anLxxCollection add: 1.
	self assert: (anLxxCollection remove: 1 ifAbsent: [ nil ]) = 1.


]

{ #category : #accessing }
LxxOrderedCollectionTest >> testSelect [
	| anLxxCollection result |
	anLxxCollection := LxxOrderedCollection new.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection select: [:each | each > 1 ].
	self assert: result size equals: 1.
	self assert: (result at: 1) equals: 2.
	
]
