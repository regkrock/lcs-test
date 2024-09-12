Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsLegalEntitiesModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsLegalEntitiesModuleConfiguration
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> moduleName [
	^ 'Legal Entities Module'
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> organizationsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'organizations';
		addSlotType: LcsOrganizations;
		addCollectionMemberType: LcsCountry;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LcsPersons;
		addCollectionMemberType: LcsPerson;
		yourself
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations [
	^ organizations
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations: anObject [
	organizations := anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons [
	^ persons
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons: anObject [
	persons := anObject
]
