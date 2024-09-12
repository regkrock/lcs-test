Class {
	#name : #LcsCodeBuilderJobTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeBuilderJobTest >> testAddingAJobStep [
	| builderJob |
	builderJob := LcsDomainGlobalClassBuilderJob new.
	builderJob addJobStep: LcsCodeSuperClassBuilder new.
	self assert: builderJob jobSteps hasJobSteps.
	self assert: builderJob jobSteps collection size equals: 1.
	self assert: builderJob jobSteps collection any parent equals: builderJob jobSteps.
	self assert: builderJob jobSteps collection any builderJob identicalTo: builderJob
]

{ #category : #test }
LcsCodeBuilderJobTest >> testCreation [
	| builderJob |
	builderJob := LcsDomainGlobalClassBuilderJob new.
	self assert: (builderJob jobSteps isKindOf: LcsCodeBuilderJobSteps).
	self assert: builderJob jobSteps parent identicalTo: builderJob.
	self assert: builderJob jobSteps hasNoJobSteps.
	self assert: builderJob classPrefix equals: 'Lcs'.
	self assert: builderJob targetPackageName isNil.
	self assert: builderJob completedRefactorings isEmpty
]
