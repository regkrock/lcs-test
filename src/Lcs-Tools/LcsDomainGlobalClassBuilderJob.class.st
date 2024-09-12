Class {
	#name : #LcsDomainGlobalClassBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'classPrefix',
		'completedRefactorings',
		'jobSteps',
		'targetPackageName',
		'domainInstanceSlotName',
		'classRootName',
		'globalCollectionSlotName',
		'domainClassName',
		'targetDomainClasses',
		'targetModuleName',
		'targetModuleClass'
	],
	#category : #'Lcs-Tools'
}

{ #category : #build }
LcsDomainGlobalClassBuilderJob >> addCompletedRefactoring: aRefactoring [ 
	self completedRefactorings add: aRefactoring
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> addJobStep: aBuilderJobStep [ 
	self jobSteps addJobStep: aBuilderJobStep
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self domainClassMemberSlotBuilder: eachClass) ]
]

{ #category : #query }
LcsDomainGlobalClassBuilderJob >> builderJob [
	^self
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classRootName: aString [
	classRootName := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> completedRefactorings [
	^ completedRefactorings
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> completedRefactorings: anObject [
	completedRefactorings := anObject
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self domainInstanceSlotName: (self domainSlotNameFrom: self classRootName).
	self globalCollectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self domainClassName: self classPrefix , aRootName.
	self globalCollectionClassName: self domainClassName asEnglishPlural
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> domainClassMemberSlotBuilder: eachClass [ 
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		targetClassName: eachClass name;
		yourself
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainClassName [
	^ domainClassName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainClassName: anObject [ 
	domainClassName := anObject
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #private }
LcsDomainGlobalClassBuilderJob >> domainSlotNameFrom: aRootName [
	^ (aRootName at: 1) asLowercase asString , (aRootName copyFrom: 2 to: aRootName size)
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionClassName [
	^ globalCollectionClassName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionClassName: anObject [ 
	globalCollectionClassName := anObject
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self domainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self targetModuleName;
		yourself
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionSlotName [
	^ globalCollectionSlotName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionSlotName: aString [
	globalCollectionSlotName := aString
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> gtStepsMondrianTreeFor: aView [
	<gtView>
	^ aView empty
"	self jobSteps hasNoJobSteps ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]"
]

{ #category : #iniitialize }
LcsDomainGlobalClassBuilderJob >> initialize [
	super initialize.
	self
		jobSteps: (LcsCodeBuilderJobSteps newOn: self);
		classPrefix: 'Lcs';
		completedRefactorings: OrderedCollection new.
]

{ #category : #build }
LcsDomainGlobalClassBuilderJob >> installCode [
	self jobSteps installCode
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> jobStepDescription [
	^ self printString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			LcsCodeBuilderStepElement newFromStep: each ];
		with: (self withDeepCollect: #jobSteps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #steps.
	view layout custom: (GtGradWestHierarchicalLayout new alignment: GtGradHierarchicalLayoutRootAlignment new)
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> stateColor [
	^Color green
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> stepIcon [
	<return: #BlElement or: nil>
	^ nil
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self targetModuleName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName := self targetModuleClass moduleName ]
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : #'slot model' }
LcsDomainGlobalClassBuilderJob >> verifyCodeInstallation [
	self jobSteps verifyCodeInstallation
]
