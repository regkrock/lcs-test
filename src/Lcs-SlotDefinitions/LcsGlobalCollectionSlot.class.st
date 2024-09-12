"
This is used to define a global collection slot. All of the items stored in this collection are rooted in this collection.
"
Class {
	#name : #LcsGlobalCollectionSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionMemberTypes',
		'collectionSlotClass'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsGlobalCollectionSlot >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : #configuration }
LcsGlobalCollectionSlot >> beIdentitySetCollection [
	self collectionSlotCollectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #configuration }
LcsGlobalCollectionSlot >> beOrderedCollection [
	self collectionSlotCollectionClass: OrderedCollection
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionSlotCollectionClass [
	^ collectionSlotClass
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionSlotCollectionClass: anObject [
	collectionSlotClass := anObject
]

{ #category : #initialize }
LcsGlobalCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : #testing }
LcsGlobalCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self getValueIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
