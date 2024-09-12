"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'status',
		'systemDomainClasses',
		'systemSlotModel'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #testing }
LcsBaseSystem class >> isApplicationSystemClass [
	^ true
]

{ #category : #configuration }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #'instance creation' }
LcsBaseSystem class >> new [
	"A factory pattern is used here. The creation of the system is delegated to the system manager"
	^ LcsApplicationEnvironment createCurrentSystemFor: self
]

{ #category : #accessing }
LcsBaseSystem >> _restoreSystem [
	self suspendCurrentSystem.
	self
		restoreUnitOfWork;
		restoreSlotModel;
		status: (LcsSystemActiveStatus newOn: self).
	self systemManager currentSystem: self
]

{ #category : #accessing }
LcsBaseSystem >> _suspendSystem [ 
	self 
		releaseSlotModel;
		suspendUnitOfWork;
		status: (LcsSystemSuspendedStatus newOn: self ).
	self systemManager currentSystem: nil
]

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotDefinitions [
	self systemSlotModel addToSlotModel: aSlotDefinitions
]

{ #category : #modules }
LcsBaseSystem >> allModuleClasses [
	| moduleClasses |
	moduleClasses := OrderedCollection new.
	self class addModuleClassesTo: moduleClasses.
	^moduleClasses
]

{ #category : #'slot model' }
LcsBaseSystem >> baseDomainModelClasses [
	^OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseModule;
		add: LcsModule;
		add: LcsBaseSystem;
		add: LcsDomainCollection;
		add: LcsCode;
		add: LcsSingletonCode;
		add: LcsCodes;
		add: LcsBaseConfiguration;
		yourself
]

{ #category : #'slot model' }
LcsBaseSystem >> buildSlotDefinitions [
	self systemDomainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotModel ]
]

{ #category : #accessing }
LcsBaseSystem >> configurationValidator [
	^ LcsSystemConfigurationValidator new
		validate: self;
		yourself
]

{ #category : #'unit of work' }
LcsBaseSystem >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'slot model' }
LcsBaseSystem >> gtAllSystemsFor: aView [
	<gtView>
	(LcsApplicationEnvironment isInActiveStatus)
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Systems';
		priority: 50;
		object: [ LcsApplicationEnvironment systemManager ];
		view: #gtAllSystemsFor:;
		yourself
]

{ #category : #'gt view' }
LcsBaseSystem >> gtConfigurationIssuesFor: aView [
	<gtView>
	self configurationValidator hasNoValidationIssues
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Configuration Issues';
		priority: 1;
		object: [ self configurationValidator ];
		view: #gtConfigurationIssuesFor:;
		yourself
]

{ #category : #'slot model' }
LcsBaseSystem >> gtSystemSlotModelFor: aView [
	<gtView>
	(self systemSlotModel isNil or: [self hasSystemSlotModels not])
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'System Slot Model';
		priority: 1;
		object: [ self systemSlotModel ];
		view: #gtSystemSlotModelFor:;
		yourself
]

{ #category : #'slot model' }
LcsBaseSystem >> gtUnitOfWorkFor: aView [
	<gtView>
	self slotModel isNil ifTrue: [ ^ aView empty ].
	self currentUnitOfWork isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Unit Of Work';
		priority: 2;
		object: [ self relatedUnitOfWork ];
		view: #gtUnitOfWorkFor:;
		yourself
]

{ #category : #accessing }
LcsBaseSystem >> hasSlotModelFor: aClass [
	^ self systemSlotModel hasSlotModelFor: aClass
]

{ #category : #testing }
LcsBaseSystem >> hasSystemSlotModels [
	^ self systemSlotModel hasSlotModels
]

{ #category : #testing }
LcsBaseSystem >> hasValidConfiguration [
	^ self configurationValidator hasNoValidationIssues
]

{ #category : #'slot model' }
LcsBaseSystem >> initialSystemDomainClasses [
	^ self requiredSystemDomainClasses
]

{ #category : #initialize }
LcsBaseSystem >> initializeInNewUnitOfWork: aSystemManger [
	| newUnitOfWork |
	
	newUnitOfWork := aSystemManger unitsOfWorkManager createUnitOfWork.
	newUnitOfWork system: self.
	newUnitOfWork addObject: self. "Need to add to unit of work"
	parent := aSystemManger.
	self initialize.
	self currentUnitOfWork applyChanges.

]

{ #category : #initialize }
LcsBaseSystem >> initializeInUnitOfWork: aUnitOfWork [
	aUnitOfWork system: self.
	aUnitOfWork addObject: self. "Need to add to unit of work"
	self initialize.
	self currentUnitOfWork applyChanges.

]

{ #category : #initialize }
LcsBaseSystem >> initializeSystem [
	super initializeSystem.
	self
		systemDomainClasses: self initialSystemDomainClasses;
		status: (LcsSystemActiveStatus newOn: self);
		systemSlotModel: (LcsSystemSlotModel newOn: self);
		buildSlotDefinitions;
		buildModules


]

{ #category : #testing }
LcsBaseSystem >> isApplicationSystem [
	^ true
]

{ #category : #testing }
LcsBaseSystem >> isIncludedInSystemDomainClasses: aDomainClass [
	^ self systemDomainClasses includes: aDomainClass class
]

{ #category : #printing }
LcsBaseSystem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self statusNameString;
		nextPutAll: ')'
]

{ #category : #'unit of work' }
LcsBaseSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : #'slot model' }
LcsBaseSystem >> releaseSlotModel [
	self parent releaseSlotModel
]

{ #category : #remove }
LcsBaseSystem >> removeSystem [ 
	parent removeSystem: self
]

{ #category : #'slot model' }
LcsBaseSystem >> requiredSystemDomainClasses [
	| modelClasses |
	modelClasses := OrderedCollection new
		addAll: self baseDomainModelClasses;
		add: self class;
		addAll: self moduleClasses;
		yourself.
	self moduleClasses deep: [ :each | each moduleClasses ] do: [ :each | modelClasses add: each ].
	^ modelClasses
]

{ #category : #restore }
LcsBaseSystem >> restoreSlotModel [
	self systemSlotModel restoreSlotModel
]

{ #category : #restore }
LcsBaseSystem >> restoreSystem [
	self status restoreSystem
]

{ #category : #restore }
LcsBaseSystem >> restoreUnitOfWork [
	parent restoreUnitOfWorkFor: self
]

{ #category : #accessing }
LcsBaseSystem >> status [
	^ status
]

{ #category : #accessing }
LcsBaseSystem >> status: aSystemStatus [ 
	status := aSystemStatus
]

{ #category : #printing }
LcsBaseSystem >> statusNameString [
	^ self status ifNil: [ 'no status' ] ifNotNil: [ self status statusName ]
]

{ #category : #suspend }
LcsBaseSystem >> suspendCurrentSystem [
	self systemManager suspendCurrentSystem
]

{ #category : #suspend }
LcsBaseSystem >> suspendSystem [
	self status suspendSystem
]

{ #category : #suspend }
LcsBaseSystem >> suspendUnitOfWork [
	parent suspendUnitOfWorkFor: self
]

{ #category : #accessing }
LcsBaseSystem >> systemDomainClasses [
	^ systemDomainClasses
]

{ #category : #accessing }
LcsBaseSystem >> systemDomainClasses: anObject [
	systemDomainClasses := anObject
]

{ #category : #accessing }
LcsBaseSystem >> systemManager [
	^ parent
]

{ #category : #accessing }
LcsBaseSystem >> systemSlotModel [
	^ systemSlotModel
]

{ #category : #accessing }
LcsBaseSystem >> systemSlotModel: anObject [
	systemSlotModel := anObject
]

{ #category : #accessing }
LcsBaseSystem >> toggleActionButtonLabel [
	^ self status toggleActionButtonLabel
]

{ #category : #accessing }
LcsBaseSystem >> toggleStatus [
	self status toggleStatus
]

{ #category : #'unit of work' }
LcsBaseSystem >> unitOfWork [
	^ self currentUnitOfWork
]
