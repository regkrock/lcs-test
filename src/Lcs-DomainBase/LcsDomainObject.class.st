Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'slotModel'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot model' }
LcsDomainObject class >> addSlotDefinitions [
	self slotDefinitionPragmas
		do: [ :eachPragma | self installSlotDefinition: eachPragma methodSelector ]
]

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #'slot model' }
LcsDomainObject class >> assertDomainSlotRemoved: aSlotName [
	self assert: (self hasSlotDefinitionNamed: aSlotName) not.
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #'slot model' }
LcsDomainObject class >> assertSlotAdded: aSlotName [
	self assert: (self instVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'application environment' }
LcsDomainObject class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #'gt view' }
LcsDomainObject class >> gtViewDomainSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	self slotModel ifNil: [ 
		^ aView list
			title: 'Domian Slot Definitions';
			priority: 10;
			items: [ Array with: 'Not initialized' ];
			yourself].	
	^ aView forward
		title: 'Domain Slot Definitions';
		priority: 10;
		object: [ self slotModel ];
		view: #gtViewDomainSlotDefinitionsFor:;
		yourself
		
]

{ #category : #testing }
LcsDomainObject class >> hasNoninitializedApplicationEnvironment [
	^ self isSlotModelReleased
]

{ #category : #'slot model' }
LcsDomainObject class >> hasSlotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ false ].
	^ self slotModel hasSlotDefinitionNamed: aString
]

{ #category : #'application environment' }
LcsDomainObject class >> initializeApplicationEnvironment [
]

{ #category : #'slot model' }
LcsDomainObject class >> initializeSlotModel [
	self slotModel: (LcsSlotModel newOn: self).
	self currentSystem addToSlotModel: self slotModel.
	self addSlotDefinitions
]

{ #category : #'slot model' }
LcsDomainObject class >> installSlotDefinition: aSlotDefinitionSelector [
	^ self slotModel addSlotDefinition: (self perform: aSlotDefinitionSelector)
]

{ #category : #testing }
LcsDomainObject class >> isDomainClass [
	^ true
]

{ #category : #testing }
LcsDomainObject class >> isRootDomainClass [
	^ self name == #'LcsDomainObject'
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelDefined [
	^ self slotModel notNil 
]

{ #category : #testing }
LcsDomainObject class >> isSlotModelReleased [
	self slotModel notNil ifTrue: [ ^ false ].
	self subclasses do: [ :each | each isSlotModelReleased ].
	^ true
]

{ #category : #'instance creation' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew.
	self currentSystem ifNotNil: [ self addToUnitOfWork: newObject ]..
	newObject initialize.
	^ newObject
]

{ #category : #'slot definition' }
LcsDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]

{ #category : #'application environment' }
LcsDomainObject class >> releaseApplicationEnvironment [
	self releaseSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> releaseSlotModel [
	self slotModel: nil.
	self subclassesDo: [ :each | each releaseSlotModel ]
]

{ #category : #'slot model' }
LcsDomainObject class >> removeDomainSlotNamed: aSlotName [
	self slotModel removeSlotDefinitionNamed: aSlotName.
	self removeInstVar: aSlotName.
	self removeGetter: aSlotName asSymbol.
	self removeSetter: (aSlotName , ':') asSymbol.
	self removeSlotDefinition: (aSlotName , 'SlotDefinition') asSymbol
]

{ #category : #'slot model' }
LcsDomainObject class >> removeGetter: aGetter [
	(self canUnderstand: aGetter)
		ifTrue: [ self removeSelector: aGetter ]
]

{ #category : #'slot model' }
LcsDomainObject class >> removeInstVar: aSlotName [
	(self instVarNames includes: aSlotName)
		ifTrue: [ self removeInstVarNamed: aSlotName ]
]

{ #category : #'slot model' }
LcsDomainObject class >> removeSetter: aSetterSelector [
	(self canUnderstand: aSetterSelector)
		ifTrue: [ self removeSelector: aSetterSelector ]
]

{ #category : #'slot model' }
LcsDomainObject class >> removeSlotDefinition: aSlotDefinitionSelector [
	(self class canUnderstand: aSlotDefinitionSelector)
		ifTrue: [ self class removeSelector: aSlotDefinitionSelector ]
]

{ #category : #'slot model' }
LcsDomainObject class >> restorelotModel [
	self initializeSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionNamed: aString [ 
	self slotModel ifNil: [ ^ LcsSlotModelNotInitializedError signal: ('Slot Definitions not initialized in ' , self name) ].
	^ [ self slotModel slotDefinitionNamed: aString ]
		on: LcsSlotDoesNotExistInSlotModelHeirarchyError
		do: [:s |
			LcsSlotDoesNotExistInSlotModelError signal: ('Slot ' , aString printString  , ' not defined in slot model') ]
]

{ #category : #'slot model' }
LcsDomainObject class >> slotDefinitionPragmas [
	^ Pragma allNamed: 'slotDefinition' in: self class
]

{ #category : #accessing }
LcsDomainObject class >> slotModel [
	^ slotModel
]

{ #category : #accessing }
LcsDomainObject class >> slotModel: aSlotModel [
	slotModel := aSlotModel
]

{ #category : #'slot model' }
LcsDomainObject class >> verifyClassHasDomainSlotNamed: aSlotName [
	self assert: (self instVarNames includes: aSlotName).
	self assert: (self canUnderstand: aSlotName asSymbol).
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol).
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol)
]

{ #category : #'slot model' }
LcsDomainObject class >> verifyClassHasNoDomainSlotNamed: aSlotName [
	self assert: (self instVarNames includes: aSlotName) not.
	self assert: (self canUnderstand: aSlotName asSymbol) not.
	self assert: (self canUnderstand: (aSlotName , ':') asSymbol) not.
	self assert: (self class canUnderstand: (aSlotName , 'SlotDefinition') asSymbol) not
]

{ #category : #validation }
LcsDomainObject >> addValidateConfigurationResultTo: aValidator [
	self isIncludedInSystemDomainClasses
		ifTrue: [self slotModel class name = #LcsSlotModel
					ifFalse: [ aValidator addIssueMessage: 'Slot Model not defined for ' , self className ]]
		ifFalse: [
			self slotModel notNil
				ifTrue: [ aValidator addIssueMessage: 'Slot Model is defined but not in the system model collection  ' ]].
	aValidator validate: self slotModel
]

{ #category : #'application environment' }
LcsDomainObject >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> getValueOfSlotNamed: aSlotName [
	^ (self slotDefinitionNamed: aSlotName) getValueIn: self
]

{ #category : #'gt view' }
LcsDomainObject >> gtViewDomainSlotDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	^ self class gtViewDomainSlotDefinitionsFor: aView
]

{ #category : #iniitialize }
LcsDomainObject >> initialize [
	super initialize.
	self initializeModel.
]

{ #category : #iniitialize }
LcsDomainObject >> initializeModel [
	self initializeSlotValues

]

{ #category : #'slot model' }
LcsDomainObject >> initializeSlotNamed: aSlotName [
	self slotModel initializeSlotNamed: aSlotName in: self
]

{ #category : #iniitialize }
LcsDomainObject >> initializeSlotValues [
	self slotModel ifNil: [ LcsSlotModelNotInitializedError signal: ('Slot Definitions not initialized in ' , self className asString ) ].
	self slotModel initializeSlotValuesIn: self.

]

{ #category : #accessing }
LcsDomainObject >> isDomainObject [
	^ true
]

{ #category : #validation }
LcsDomainObject >> isIncludedInSystemDomainClasses [
	^ self currentSystem isIncludedInSystemDomainClasses: self
]

{ #category : #testing }
LcsDomainObject >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self parentSlotDefinition isGlobalCollectionRefenceSlotTo: aSlotName
]

{ #category : #accessing }
LcsDomainObject >> isRootDomainClass [
	self class isRootDomainClass
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ self getValueOfSlotNamed: 'parent'
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	self getValueOfSlotNamed: 'parent'
]

{ #category : #'slot model' }
LcsDomainObject >> parentSlotDefinition [
	^ self slotModel parentSlotDefinition
]

{ #category : #'slot definitions' }
LcsDomainObject >> setValueOfSlotNamed: aSlotName to: onObject [
	(self slotDefinitionNamed: aSlotName) setValueTo: onObject in: self
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotDefinitionNamed: aString [
	^ self class slotDefinitionNamed: aString
]

{ #category : #'slot definitions' }
LcsDomainObject >> slotModel [
	^ self class slotModel
]
