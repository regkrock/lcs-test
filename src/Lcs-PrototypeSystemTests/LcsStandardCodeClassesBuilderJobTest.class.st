Class {
	#name : #LcsStandardCodeClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> jobBuilder [
	^ LcsStandardCodeClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		createForRootName: 'Talent';
		createCodeInstances: #(#('Guitar') #('Saxaphone'));
		targetModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> removeAllArtifacts [
	LxxPrototypeSystem removeDomainSlotNamed: 'talents'.
	LxxPrototypePerson removeDomainSlotNamed: 'talent'.
	self
		removeClassesNamed: #('LxxTalent' 'LxxTalents')
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #running }
LcsStandardCodeClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder targetPackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder classRootName equals: 'Talent'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder domainInstanceSlotName equals: 'talent'.
	self assert: builder globalCollectionSlotName equals: 'talents'.
	self assert: builder domainClassName equals: 'LxxTalent'.
	self assert: builder globalCollectionClassName equals: 'LxxTalents'.
	self assert: builder targetModuleClass equals: LxxPrototypeSystem.

]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase2_BuildJobSteps [
	| builder builderJobStep |
	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 5.

	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsCodeSuperClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsCode'.
	self assert: builderJobStep newClassName equals: 'LxxTalent'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.

	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsCodeCollectionClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsCodes'.
	self assert: builderJobStep newClassName equals: 'LxxTalents'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxTalent'.
	self assert: builderJobStep collectionSlotName equals: 'talents'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxPrototypeSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep slotClassName equals: 'LxxTalents'.
	self assert: builderJobStep slotName equals: 'talents'.


	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypePerson.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep collectionSlotName equals: 'talents'.
	self assert: builderJobStep slotName equals: 'talent'.
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase3_InstallCode [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase4_UpdateSlotModel [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.

	builder updateSlotModel.
	builder verifySlotModelUpdates.

]

{ #category : #tests }
LcsStandardCodeClassesBuilderJobTest >> testCreatingJobToAddTalentCodeAndInstallTalentSlotInPerson_Phase5_Populate [
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
