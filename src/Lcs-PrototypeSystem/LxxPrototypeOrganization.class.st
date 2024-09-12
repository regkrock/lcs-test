Class {
	#name : #LxxPrototypeOrganization,
	#superclass : #LcsDomainObject,
	#instVars : [
		'chiefExecutiveOfficer'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definition' }
LxxPrototypeOrganization class >> chiefExecutiveOfficerSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'chiefExecutiveOfficer';
		collectionSlotName: 'persons';
		collectionModuleName: LxxPrototypePersonsModule moduleName;
		beRequired;
		yourself
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer [
	^ self getValueOfSlotNamed: 'chiefExecutiveOfficer'
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer: aPerson [
	self setValueOfSlotNamed: 'chiefExecutiveOfficer' to: aPerson
]
