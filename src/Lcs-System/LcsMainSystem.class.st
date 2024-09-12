Class {
	#name : #LcsMainSystem,
	#superclass : #LcsBaseSystem,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-System'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #modules }
LcsMainSystem class >> moduleClasses [
	^ OrderedCollection new
		add: LcsGeographyModule;
		add: LcsLegalEntitiesModule;
		yourself
]

{ #category : #'slot model' }
LcsMainSystem >> initialSystemDomainClasses [
	<todo: 'Refactor to make this mor efficient'>
	^ super initialSystemDomainClasses
		addAll: (LcsDomainObject withAllSubclasses
				reject: [ :eachDomainClass | 
					(eachDomainClass name beginsWith: 'Lxx')
						or: [ self requiredSystemDomainClasses includes: eachDomainClass ] ]);
		yourself
]
