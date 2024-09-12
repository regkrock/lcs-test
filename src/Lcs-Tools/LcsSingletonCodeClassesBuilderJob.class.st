Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeSubclassBuilders'
	],
	#category : #'Lcs-Tools'
}

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassBuilders [
	self codeSubclassBuilders
		do: [ :eachBuilder | 
			self
				addJobStep: (eachBuilder
						targetSuperclassName: self domainClassName;
						targetPackageName: self targetPackageName;
						yourself) ]
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addCodeSubclassBuilders.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> codeClassBuilder [
	^ super codeClassBuilder
		targetSuperclassName: 'LcsSingletonCode';
		yourself
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsSingletonCodeClassBuilder new
		rootName: aString;
		newClassName: self classPrefix , aString;
		targetSuperclassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders [
	^ codeSubclassBuilders
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders: aCollection [
	codeSubclassBuilders := aCollection
]

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeSubclassBuilders: OrderedCollection new
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self singletonClassBuilders do: [ :eachStep | eachStep populateSlotModel ].
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> singletonClassBuilders [
	^ self jobSteps stepsWithClass: LcsSingletonCodeClassBuilder
]

{ #category : #'slot model' }
LcsSingletonCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection size = self singletonClassBuilders size.
	self singletonClassBuilders
		do: [ :eachStep | 
			self assert: (self targetGlobalCollection findWithKey: eachStep codeName) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
