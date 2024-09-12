Class {
	#name : #LcsMemberOfSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionSourceBlock',
		'collectionSlotName',
		'collectionModuleName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'application environment' }
LcsMemberOfSlot >> collectionModule [
	^ self currentSystem moduleNamed: self collectionModuleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionModuleName [
	^ collectionModuleName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionModuleName: aString [ 
	collectionModuleName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionSlotName: aString [ 
	collectionSlotName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> collectionmoduleName: aString [ 
	collectionModuleName := aString
]

{ #category : #accessing }
LcsMemberOfSlot >> defaultInstance [
	^ self targetCollection defaultInstance
]

{ #category : #initialize }
LcsMemberOfSlot >> initialize [
	super initialize.
	self beRequired.
	self initialValueBlock: [ self defaultInstance ]
]

{ #category : #accessing }
LcsMemberOfSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]
