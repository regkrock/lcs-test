Class {
	#name : #LcsDomainClassClassesBuilderJob,
	#superclass : #LcsDomainGlobalClassBuilderJob,
	#instVars : [
		'protoInstances',
		'undefinedClassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> buildJobSteps [
	self addJobStep: self domainClassBuilder.
	self addJobStep: self domainUnknownClassBuilder.
	self addJobStep: self domainCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self globalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> createForRootName: aRootName [
	super createForRootName: aRootName.
	self undefinedClassName: self classPrefix , 'Unknown' , aRootName
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> createInstances: aCollection [
	aCollection do: [ :each |
		self protoInstances add: each ]
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassBuilder [
	^ LcsDomainClassBuilder new
		newClassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> domainClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsDomainClassBuilder) first
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassCodeMemberSlotBuilder: eachClass [
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainClassMemberSlotBuilder: eachClass [
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		targetClassName: eachClass name;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainCollectionClassBuilder [
	^ LcsDomainCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> domainUnknownClassBuilder [
	^ LcsUnknownClassBuilder new
		newClassName: self undefinedClassName;
		targetSuperclassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsDomainClassClassesBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self domainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self targetModuleName;
		yourself
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> globalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetModuleClass: self targetModuleClass;
		yourself
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Construction Steps Tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]

{ #category : #'gt views' }
LcsDomainClassClassesBuilderJob >> gtPaintTreeWith: aMondrian [ 

self
	withDeep: [ :each | each jobSteps collect: [:eachStep | eachStep]  ]
	do: [ :each | 
		aMondrian nodes
			stencil: [ :x | 
				BrVerticalPane new
					fitContent;
					addChild: (BrLabel new
							text: x class name;
							aptitude: (BrGlamorousLabelAptitude new
									foreground: Color gray;
									fontSize: 10));
					addChild: (BrLabel new
							text: x jobStepDescription;
							aptitude: BrGlamorousLabelAptitude new) ];
			with: {each} ]
	relationDo: [ :from :to | 
		aMondrian edges
			fromRightCenter;
			toLeftCenter;
			stencil: [ :x | 
				BlParabollaArcElement new
					zIndex: 0;
					curvatureFraction: 0.0;
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
					toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder
									paint: (Color gray alpha: 0.2);
									width: 4;
									build)) ];
			connectAssociations: {from -> to} ].
aMondrian layout custom: (GtGraphHorizontalTreeLayout new
	levelDistance: 50;
	nodeDistance: 20).
aMondrian
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> initialize [
	super initialize.
	self protoInstances: OrderedCollection new.
	self targetDomainClasses: Set new
]

{ #category : #printing }
LcsDomainClassClassesBuilderJob >> jobStepDescription [
	^ (WriteStream on: String new) 
		nextPutAll: '1) Install ';
		nextPutAll: self domainClassName ;
		cr;
		nextPutAll: ' with instances  stored in ';
		nextPutAll: self globalCollectionClassName;
		contents
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self unknownClass new.
	"self protoInstances do: [ :each | 
		self domainClassBuilderStep installedClass new
			isoCode: (each at: 1);
			countryName: (each at: 2)]."
	self currentSystem currentUnitOfWork applyChanges.
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> protoInstances [
	^ protoInstances
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> protoInstances: aCollection [
	protoInstances := aCollection
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> undefinedClassName [
	^ undefinedClassName
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> undefinedClassName: anObject [
	undefinedClassName := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> unknownClass [
	^ self unknownClassBuilderStep installedClass
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> unknownClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsUnknownClassBuilder) first
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #verification }
LcsDomainClassClassesBuilderJob >> verifySlotModelUpdates [
	self jobSteps verifySlotModelUpdates
]
