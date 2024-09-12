Class {
	#name : #LxxPrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototypePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LxxPrototypePerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem moduleName;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]
