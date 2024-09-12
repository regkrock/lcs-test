Class {
	#name : #LxxPrototypeSystemTest,
	#superclass : #LcsDomainTest,
	#instVars : [
		'system1',
		'system2'
	],
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #accessing }
LxxPrototypeSystemTest >> system1 [
	^ system1
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system1: anObject [
	^ system1 := anObject
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system2 [
	^ system2
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system2: anObject [
	^ system2 := anObject
]

{ #category : #running }
LxxPrototypeSystemTest >> tearDown [
	self system1 ifNotNil: [ 
		self system1 removeSystem.
		self system1: nil ].
	self system2 ifNotNil: [ 
		self system2 removeSystem.
		self system2: nil ].
	super tearDown

]

{ #category : #tests }
LxxPrototypeSystemTest >> testChangedSlotInDomainObject [
	| domainObject |
	self system1: LxxPrototypeSystem new.
	domainObject := LxxPrototypePerson new dateOfBirth: Date today.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: domainObject dateOfBirth equals: Date today.
	self assert: ((self currentSystem persons) includes: domainObject).
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

	domainObject dateOfBirth: Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects size equals: 1.
	self assert: (self currentSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: self currentSystem currentUnitOfWork changedObjects any domainObject identicalTo: domainObject.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth = Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreatingNewDomainObject [
	| domainObject |
	self system1: LxxPrototypeSystem new.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := self domainObjectClass new.
	self assert: self currentSystem currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: self currentSystem currentUnitOfWork addedObjects any domainObject identicalTo: domainObject
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreation [
	| system |
	system := LxxPrototypeSystem new.
	self assert: self currentSystem identicalTo: system.
	self assert: (system moduleNamed: LxxPrototypePersonsModule moduleName) class name equals: #LxxPrototypePersonsModule.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) class name equals: #LxxPrototype2Module.
	self assert: system numberOfChildModules equals: 2. 
	self assert: (system moduleNamed: LxxPrototypePersonsModule moduleName) numberOfChildModules equals: 0.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) numberOfChildModules equals: 1.
	self assert: (system moduleNamed: LxxPrototype2Submodule moduleName) numberOfChildModules equals: 0.
	self assert:system hasValidConfiguration. 
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationOfNewSystem [
	self system1: LxxPrototypeSystem new.
	self assert: self currentSystem class identicalTo: LxxPrototypeSystem.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPrototypePersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationWithPrototypeSystem [
	| domainObject |
	self system1: LxxPrototypeSystem new.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem identicalTo:self system1.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject identicalTo: domainObject.
	self assert: domainObject slotModel className equals: 'LcsSlotModel' .
]

{ #category : #accessing }
LxxPrototypeSystemTest >> testInstallingFirstNameSlotInPerson [
	self deny: (LxxPrototypePerson instVarNames includes: 'firstName').
	self deny: (LxxPrototypePerson respondsTo: #firstName).
	self deny: (LxxPrototypePerson respondsTo: #firstName:).
	self deny: (LxxPrototypePerson class respondsTo: #firstNameSlotDefinition).
]

{ #category : #tests }
LxxPrototypeSystemTest >> testNewUnitOfWorkInSystem [
	self system1: LxxPrototypeSystem new.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : #tests }
LxxPrototypeSystemTest >> testPrototypeSystemCreation [
	| allDomainClasses |

	self system1: LxxPrototypeSystem new.
	self assert: self system1 currentUnitOfWork hasNoChanges.
	self assert: (self system1 slotDefinitionNamed: 'persons') notNil.
	self assert: self system1 persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self system1 configuration class name equals: #LxxPrototypeSystemConfiguration.
	self assert: self system1 hasSystemSlotModels .
	self assert: self system1 systemSlotModel slotModels size equals: LcsApplicationEnvironment currentSystem initialSystemDomainClasses size.
	allDomainClasses := self domainObjectClass withAllSubclasses asOrderedCollection.
	self system1 systemSlotModel slotModels keysDo: [ :each | allDomainClasses remove: each ifAbsent: [ ] ].
	self assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotModel isNil ])
]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemCreation [
	| numberOfSystems |
	numberOfSystems := self systemManager numberOfSystems.
	self system1: LxxPrototypeSystem new. 

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system1.
	self assert: LcsApplicationEnvironment currentUnitOfWork identicalTo: self system1 relatedUnitOfWork.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: self system1 hasValidConfiguration.

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPrototypePersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration.

]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemRemoval [
	| numberOfSystems numberOfUnitsOfWork |
	
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.

	self system1: LxxPrototypeSystem new.
	self system2:LxxPrototypeSystem new.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2. 
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system1) system identicalTo: self system1.
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system2) system identicalTo: self system2.

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system2.
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self system1.
	self assert: LcsDomainObject isSlotModelReleased not.


]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemSuspend [
	| numberOfSystems numberOfUnitsOfWork |
	
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	self system1: LxxPrototypeSystem new.
	self assert: LcsDomainObject isSlotModelReleased not.
	self system2: LxxPrototypeSystem new.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2. 
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system1) system identicalTo: self system1.
	self assert: (self unitsOfWorkManager unitOfWorkFor: self system2) system identicalTo: self system2.

	self assert: LcsApplicationEnvironment currentSystem identicalTo: self system2.
	LcsApplicationEnvironment suspendCurrentSystem.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self system1.
	self assert: LcsDomainObject isSlotModelReleased not.



]
