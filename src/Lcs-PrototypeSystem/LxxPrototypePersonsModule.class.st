Class {
	#name : #LxxPrototypePersonsModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #configuration }
LxxPrototypePersonsModule class >> moduleName [
	^ 'Persons Module'
]

{ #category : #'slot definitions' }
LxxPrototypePersonsModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		yourself
]

{ #category : #accessing }
LxxPrototypePersonsModule >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypePersonsModule >> persons: aCollection [
	^ self setValueOfSlotNamed: 'persons' to: aCollection
]
