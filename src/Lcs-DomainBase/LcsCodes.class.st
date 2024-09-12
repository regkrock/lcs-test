Class {
	#name : #LcsCodes,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase'
}

{ #category : #testing }
LcsCodes >> defaultInstance [
	^self collection detect: [ :each | each isDefaultInstance == true]
]

{ #category : #testing }
LcsCodes >> hasDefaultInstance [
	self collection detect: [ :each | each isDefaultInstance == true] ifNone: [ ^ false ].
	^ true
]

{ #category : #testing }
LcsCodes >> hasUnknownInstance [
	self collection detect: [ :each | each codeName = 'unknown'] ifNone: [ ^ false ].
	^ true
]
