"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'persons',
		'organization'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LxxPrototypeSystemConfiguration
]

{ #category : #modules }
LxxPrototypeSystem class >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototypePersonsModule;
		add: LxxPrototype2Module;
		yourself

]

{ #category : #configuration }
LxxPrototypeSystem class >> moduleName [
	^ 'Barebones System'
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> organizationSlotDefinition [
	<slotDefinition>
	^ LcsDomainClassSlot new
		slotName: 'organization';
		addSlotType: LxxPrototypeOrganization;
		yourself
]

{ #category : #'slot definitions' }
LxxPrototypeSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'persons';
		addSlotType: LxxPrototypePersons;
		addCollectionMemberType: LxxPrototypePerson;
		yourself
]

{ #category : #initialize }
LxxPrototypeSystem >> initialSystemDomainClasses [
	^super initialSystemDomainClasses
		add: LxxPrototypeOrganization;
		add: LxxPrototypePerson;
		add: LxxPrototypeSystemConfiguration;
		add: LxxPrototypePersons;
		yourself
]

{ #category : #accessing }
LxxPrototypeSystem >> organization [
	^ self getValueOfSlotNamed: 'organization'
]

{ #category : #accessing }
LxxPrototypeSystem >> organization: anObject [
	self setValueOfSlotNamed: 'organization' to: anObject
]

{ #category : #accessing }
LxxPrototypeSystem >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxPrototypeSystem >> persons: anObject [
	self setValueOfSlotNamed: 'presons' to: anObject
]
