Class {
	#name : #LcsPerson,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LcsPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsLegalEntitiesModule moduleName;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LcsPerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LcsPerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]
