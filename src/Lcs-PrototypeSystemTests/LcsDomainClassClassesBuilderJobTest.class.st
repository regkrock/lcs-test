Class {
	#name : #LcsDomainClassClassesBuilderJobTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> jobBuilder [
	^ LcsDomainClassClassesBuilderJob new
		classPrefix: 'Lxx';
		installNewClassesInPackageNamed: 'Lcs-BarebonesSystem';
		createForRootName: 'Country';
		createInstances: #( #('CA' 'Canada') #('US' 'United States Of America'));
		targetModuleClass: LxxPrototypeSystem;
		installMemberSlotInDomainClass: LxxPrototypePerson;
		yourself
]

{ #category : #running }
LcsDomainClassClassesBuilderJobTest >> removeAllArtifacts [
	LxxPrototypeSystem removeDomainSlotNamed: 'countries'.
	LxxPrototypePerson removeDomainSlotNamed: 'country'.
	self
		removeClassesNamed: #('LxxUnknownCountry' 'LxxCountry' 'LxxCountries')
]

{ #category : #running }
LcsDomainClassClassesBuilderJobTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #running }
LcsDomainClassClassesBuilderJobTest >> tearDown [
	self removeAllArtifacts.
	super tearDown
]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase1_BuildJob [
	| builder |
	builder := self jobBuilder.

	self assert: builder classPrefix equals: 'Lxx'.
	self assert: builder targetPackageName equals: 'Lcs-BarebonesSystem'.
	self assert: builder completedRefactorings isEmpty.
	self assert: builder classRootName equals: 'Country'.
	self assert: builder jobSteps hasNoJobSteps.

	self assert: builder domainInstanceSlotName equals: 'country'.
	self assert: builder globalCollectionSlotName equals: 'countries'.
	self assert: builder domainClassName equals: 'LxxCountry'.
	self assert: builder globalCollectionClassName equals: 'LxxCountries'.
	self assert: builder targetModuleClass equals: LxxPrototypeSystem.
	self assert:builder undefinedClassName equals: 'LxxUnknownCountry'.
]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase2_BuildJobStep [
	| builder builderJobStep |

	builder := self jobBuilder.
	builder buildJobSteps.

	self assert: builder jobSteps collection size equals: 6.
	
	builderJobStep := builder jobSteps jobStepAt: 1.
	self assert: builderJobStep class identicalTo: LcsDomainClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsDomainObject'.
	self assert: builderJobStep newClassName equals: 'LxxCountry'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
	
	builderJobStep := builder jobSteps jobStepAt: 2.
	self assert: builderJobStep class identicalTo: LcsUnknownClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LxxCountry'.
	self assert: builderJobStep newClassName equals: 'LxxUnknownCountry'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.

	builderJobStep := builder jobSteps jobStepAt: 3.
	self assert: builderJobStep class identicalTo: LcsDomainCollectionClassBuilder.
	self assert: builderJobStep targetSuperclassName equals: 'LcsDomainCollection'.
	self assert: builderJobStep newClassName equals: 'LxxCountries'.
	self assert: builderJobStep targetPackageName equals: builder targetPackageName.
		
	builderJobStep := builder jobSteps jobStepAt: 4.
	self assert: builderJobStep class identicalTo: LcsGlobalCollectionReferenceSlotBuilder.
	self assert: builderJobStep targetClassName equals: 'LxxCountry'.
	self assert: builderJobStep collectionSlotName equals: 'countries'.
	self assert: builderJobStep collectionSlotModule class identicalTo: LxxPrototypeSystem.
	
	builderJobStep := builder jobSteps jobStepAt: 5.
	self assert: builderJobStep class identicalTo: LcsGlobalSlotDefinitionBuilder.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep slotClassName equals: 'LxxCountries'.
	self assert: builderJobStep slotName equals: 'countries'.


	builderJobStep := builder jobSteps jobStepAt: 6.
	self assert: builderJobStep class identicalTo: LcsMemberOfSlotBuilder.
	self assert: builderJobStep target identicalTo: LxxPrototypePerson.
	self assert: builderJobStep targetModuleClass identicalTo: LxxPrototypeSystem.
	self assert: builderJobStep collectionSlotName equals: 'countries'.
	self assert: builderJobStep slotName equals: 'country'.

]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase3_InstallCode [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation

]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase4_UpdateSlotModel [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	builder updateSlotModel.
	builder verifySlotModelUpdates.


]

{ #category : #tests }
LcsDomainClassClassesBuilderJobTest >> testCreatingCountryDomainClass_Phase5_Populate [
	| builder |
	builder := self jobBuilder.
	builder buildJobSteps.
	builder installCode.
	builder verifyCodeInstallation.
	builder updateSlotModel.
	builder verifySlotModelUpdates.
	
	self currentSystem currentUnitOfWork applyChanges.
	
	builder populateSlotModel.
	"builder verifyPopulateSlotModel."

]
