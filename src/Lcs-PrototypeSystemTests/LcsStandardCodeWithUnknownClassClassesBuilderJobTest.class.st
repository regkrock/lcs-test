Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> jobBuilder [
	^ LcsStandardCodeWithUnknownClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		createForRootName: 'Title';
		createCodeInstances: #( #('Mr') #('Ms'));
		targetModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> removeAllArtifacts [
	LxxPrototypeSystem removeDomainSlotNamed: 'titles'.
	LxxPrototypePerson removeDomainSlotNamed: 'title'.
	self
		removeClassesNamed: #('LxxUnknownTitle' 'LxxTitle' 'LxxTitles')
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #running }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder targetPackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder classRootName equals: 'Title'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder domainInstanceSlotName equals: 'title'.
	self assert: builder globalCollectionSlotName equals: 'titles'.
	self assert: builder domainClassName equals: 'LxxTitle'.
	self assert: builder globalCollectionClassName equals: 'LxxTitles'.
	self assert: builder targetModuleClass equals: LxxPrototypeSystem.
	self assert:builder undefinedClassName equals: 'LxxUnknownTitle'.
]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase2_BuildJobStep [
	| builder builderJobStep |
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 6.
	
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsCode'.
	self assert: builderJobStep newClassName equals: 'LxxTitle'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsUnknownCodeClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxTitle'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownTitle'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.

	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxTitles'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxTitle'.
	self assert: builderJobStep collectionSlotName equals: 'titles'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxPrototypeSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep slotClassName equals: 'LxxTitles'.
	self assert: builderJobStep slotName equals: 'titles'.


	builderJobStep := builder jobSteps jobStepAt: 6.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypePerson.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep collectionSlotName equals: 'titles'.
	self assert: builderJobStep slotName equals: 'title'.

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase3_InstallCode [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase4_UpdateSlotModel [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdates.


]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJobTest >> testCreatingJobToAddTitleCodesAndInstallTitleSlotInPerson_Phase5_Populate [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdates.
	
	self currentSystem currentUnitOfWork applyChanges.
	
	builder populateSlotModel.
	builder verifyPopulateSlotModel.


]
