"
This application is composed of a System and zero to many mdoules. This is the super class of all system and module classes.
"
Class {
	#name : #LcsBaseModule,
	#superclass : #LcsDomainObject,
	#instVars : [
		'modules',
		'domainCollections',
		'configuration'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #modules }
LcsBaseModule class >> addModuleClassesTo: moduleClasses [ 
	moduleClasses add: self.
	self moduleClasses do: [ :each |
		each addModuleClassesTo: moduleClasses ]
]

{ #category : #'slot definitions' }
LcsBaseModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsBaseConfiguration
]

{ #category : #asking }
LcsBaseModule class >> moduleClassNamed: aString [
	^ self allSubclasses detect: [ :eachClass |
		eachClass moduleName = aString ]
		ifNone: []
]

{ #category : #modules }
LcsBaseModule class >> moduleClasses [
	^ OrderedCollection new
]

{ #category : #configuration }
LcsBaseModule class >> moduleName [
	^ self name
]

{ #category : #building }
LcsBaseModule >> buildModule: eachModuleClass [ 
	self modules buildModuleFor: eachModuleClass
]

{ #category : #building }
LcsBaseModule >> buildModules [
	self moduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ]
]

{ #category : #accessing }
LcsBaseModule >> configuration [
	^ self getValueOfSlotNamed: 'configuration'
]

{ #category : #accessing }
LcsBaseModule >> configuration: anObject [
	self setValueOfSlotNamed: 'configuration' to: anObject
]

{ #category : #accessing }
LcsBaseModule >> domainCollections [
	^ self slotModel globalCollectionSlots collect: [ :each | self perform: each slotName asSymbol ]
]

{ #category : #accessing }
LcsBaseModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : #modules }
LcsBaseModule >> geographyModule [

	^ self moduleNamed: 'Geography Module'
]

{ #category : #accessing }
LcsBaseModule >> globalCollectionItems [
	^ self slotModel globalCollectionSlots
		collect: [ :eachSlotDefinition | 
			LcsGlobalCollectionItem
				newLabel: eachSlotDefinition slotName
				item: (self perform: eachSlotDefinition slotName asSymbol) ]
]

{ #category : #'gt views' }
LcsBaseModule >> gtApplicationModulesFor: aView [
	<gtView>
	(self modules isNil or: [ self modules isEmpty ])
		ifTrue: [ 
			^ aView list
				title: 'Modules';
				priority: 1;
				items: #('Has no submodules');
				yourself ].
	^ aView forward
		title: 'Modules';
		priority: 1;
		object: [ self modules ];
		view: #gtApplicationModulesFor:;
		yourself
]

{ #category : #'gt view' }
LcsBaseModule >> gtGlobalCollectionsFor: aView [
	<gtView>
	 self domainCollections isEmpty ifTrue: [ ^ aView empty]. 
	^ aView columnedTree
		title: 'Global Collections';
		priority: 9;
		items: [ self globalCollectionItems ];
		column: 'Slot'
			text: [ :item | item  label asString ]
			width: 100;
		column: 'Size'
			text: [ :item | item item 
								ifNil: [ '' ] 
								ifNotNil: [ item item size printString ] ]
			width: 50;
		column: 'Class'
			text: [ :item | item item class asString ]
			width: 200;
		column: 'Pending Adds'
			text: [ :item | item numberOfPendingAdds asString ]
			width: 100;
		column: 'Pending Removals'
			text: [ :item | item numberOfPendingRemovals asString ]
			width: 125;
		send: #item;
		yourself
]

{ #category : #testing }
LcsBaseModule >> hasModules [
	^ self modules hasElements
]

{ #category : #testing }
LcsBaseModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : #initialize }
LcsBaseModule >> initialize [
	self initializeSystem.	
	super initialize
]

{ #category : #initialize }
LcsBaseModule >> initializeDomainCollections [
	self domainCollections: (LcsDomainCollections new
				parent: self;
				yourself)
]

{ #category : #initialize }
LcsBaseModule >> initializeModel [
	super initializeModel.
	self modules initializeModel
]

{ #category : #initialize }
LcsBaseModule >> initializeModules [
	self modules:(LcsModules new
						parent: self;
						yourself)
]

{ #category : #initialize }
LcsBaseModule >> initializeSystem [
	self initializeModules.
	self initializeDomainCollections
]

{ #category : #modules }
LcsBaseModule >> installModule: aModuleClass [

	self currentSystem systemDomainClasses remove: LxxDemonstrationModule ifAbsent: [ ].
	aModuleClass initializeSlotModel.
	self buildModule: LxxDemonstrationModule

]

{ #category : #modules }
LcsBaseModule >> legalEntitiesModule [

	^ self moduleNamed: 'Legal Entities Module'
]

{ #category : #modules }
LcsBaseModule >> moduleClasses [
	^ self class moduleClasses
]

{ #category : #configuration }
LcsBaseModule >> moduleName [
	^ self class moduleName
]

{ #category : #modules }
LcsBaseModule >> moduleNamed: aString [
	| foundModule |
	self moduleName = aString ifTrue: [ ^ self ].
	foundModule := self modules findModuleNamed: aString.
	foundModule
		ifNil: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString asString ]
		ifNotNil: [ ^ foundModule ]
]

{ #category : #modules }
LcsBaseModule >> moduleViewChildren [
	^ self modules moduleViewChildren
]

{ #category : #accessing }
LcsBaseModule >> modules [
	^ modules
]

{ #category : #accessing }
LcsBaseModule >> modules: anObject [
	modules := anObject
]

{ #category : #modules }
LcsBaseModule >> modulesDo: aBlock [ 
	self modules do: aBlock
]

{ #category : #modules }
LcsBaseModule >> numberOfChildModules [
	^ self modules numberOfModules
]

{ #category : #accessing }
LcsBaseModule >> objectId [
	^ self hash
]

{ #category : #accessing }
LcsBaseModule >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self objectId asString;
		nextPutAll: ')'
]
