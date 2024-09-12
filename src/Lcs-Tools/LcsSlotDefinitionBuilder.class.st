Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotName',
		'target',
		'slotDefinitionSelector',
		'targetClassName',
		'targetModuleClass',
		'jobSteps'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsSlotDefinitionBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #configuration }
LcsSlotDefinitionBuilder class >> slotDefinitionClass [
	self subclassResponsibility
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addCompletedRefactoring: anObject [ 
	self parent notNil ifTrue: [ self parent addCompletedRefactoring: anObject ]
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' ,aString
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self target class includesSelector: self slotDefinitionSelector
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDoesNotAlreadyExist [
	self isInstanceVariableAlreadyCreated
		ifTrue: [ self error: 'Slot ' , self slotName , 'already exists' ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initialize [
	super initialize.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self).
	self jobSteps addJobStep: LcsSlotInstanceVariableBuilder new.
	self jobSteps addJobStep: LcsSlotDefintionMethodBuilder new.
	self jobSteps addJobStep: LcsSlotGetterAndSetterBuilder new.

]

{ #category : #iniitialize }
LcsSlotDefinitionBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #api }
LcsSlotDefinitionBuilder >> installCode [
	self jobSteps installCode
]

{ #category : #api }
LcsSlotDefinitionBuilder >> installSlotDefinition [
	self target installSlotDefinition: self slotDefinitionSelector
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> isInstanceVariableAlreadyCreated [
	^ self target allInstVarNames includes: self slotName
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> jobStepDescription [
	^ (WriteStream on: String new)
		nextPutAll: self stepNumber;
		nextPutAll: ') Install slot "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: self targetClassName;
		contents
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> refactoringText [
	| stream |
	stream := WriteStream on: String new.
	self jobSteps do: [ :each |
		stream nextPutAll: each refactoringText ] separatedBy: [ stream cr; cr ].
	^ stream contents
]

{ #category : #configuration }
LcsSlotDefinitionBuilder >> slotDefinitionClass [
	^ self class slotDefinitionClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
		ifNil: [ slotDefinitionSelector := (self slotName , 'SlotDefinition') asSymbol ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector: aSymbol [
	slotDefinitionSelector := aSymbol asSymbol
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> slotDefinitionSource [
	| codeStream |	
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotName; 
		addSlotDefinitionClassCreatonLine: self slotDefinitionClass;
		addSetter: 'slotName' contents: self slotName printString.
		
	self addSlotDefinitionSourceDetailsTo: codeStream. 
		
	^codeStream 
		addYourself;
		contents

]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName: anObject [
	.
	slotName := (anObject first asLowercase asString , (anObject copyFrom: 2 to: anObject size))
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> stepNumber [
	^ (self parent indexOf: self) printString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target [
	^target ifNil: [ target := self targetClassName asClass ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target: aClass [ 
	target := aClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName [
	^ targetClassName ifNil: [ targetClassName := self targetModuleClass name asString ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName: anObject [
	targetClassName := anObject
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass [
	^ targetModuleClass ifNil: [ targetModuleClass := #LcsBaseModule asClass moduleClassNamed: self targetModuleName ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #install }
LcsSlotDefinitionBuilder >> updateSlotModel [
	self installSlotDefinition
]

{ #category : #install }
LcsSlotDefinitionBuilder >> verifyCodeInstallation [
	self jobSteps verifyCodeInstallation
]

{ #category : #install }
LcsSlotDefinitionBuilder >> verifySlotModelUpdates [
	self jobSteps verifySlotModelUpdates
]
