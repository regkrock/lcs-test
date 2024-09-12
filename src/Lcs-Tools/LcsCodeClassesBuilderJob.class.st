Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsDomainGlobalClassBuilderJob,
	#instVars : [
		'moduleClass'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassBuilders add: classBuilder
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeClassBuilder [
	^ LcsCodeSuperClassBuilder new
		newClassName: self domainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ LcsCodeCollectionClassBuilder new
		newClassName: self globalCollectionClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #private }
LcsCodeClassesBuilderJob >> codeDescriptionFrom: anArray [
	anArray size < 2 ifTrue: [ ^ (anArray at: 1) capitalized ].
	^ anArray at: 2
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> codeGlobalCollectionSlotBuilder [
	^ LcsGlobalSlotDefinitionBuilder new
		slotClassName: self globalCollectionClassName;
		slotName: self globalCollectionSlotName;
		targetModuleClass: self targetModuleClass;
		yourself
]

{ #category : #private }
LcsCodeClassesBuilderJob >> codeNameFrom: anArray [
	(anArray at: 1) first isLowercase ifTrue: [ ^ anArray at: 1 ].
	^ (anArray at: 1) first asString asLowercase , ((anArray at: 1) copyFrom: 2 to: (anArray at: 1) size)
]

{ #category : #builders }
LcsCodeClassesBuilderJob >> domainClassCodeMemberSlotBuilder: eachClass [
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		yourself
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsGlobalSlotDefinitionBuilder) first
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> initialize [
	super initialize.
	self targetDomainClasses: OrderedCollection new
]

{ #category : #private }
LcsCodeClassesBuilderJob >> shortNameFrom: anArray [
	anArray size < 3 ifTrue: [ ^ self codeDescriptionFrom: anArray ].
	^ anArray at: 3
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> targetGlobalCollection [
	^ self targetModule perform: self globalCollectionSlotDefinitionStep getterSelector
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName :=  self targetModuleClass moduleName ]
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #verification }
LcsCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self subclassResponsibility
]

{ #category : #'slot model' }
LcsCodeClassesBuilderJob >> verifySlotModelUpdates [
	self jobSteps verifySlotModelUpdates
]
