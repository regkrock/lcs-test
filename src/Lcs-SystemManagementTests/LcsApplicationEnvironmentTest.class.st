Class {
	#name : #LcsApplicationEnvironmentTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #tests }
LcsApplicationEnvironmentTest >> testInitializeAndReleaseApplicationEnvironment [
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	self assert: LcsObject hasNoninitializedApplicationEnvironment.

	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment singleton notNil.
	self assert: (LcsApplicationEnvironment systemManager isKindOf: LcsSystemManager).
	self assert: (LcsApplicationEnvironment unitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: LcsObject hasNoninitializedApplicationEnvironment.

	LcsApplicationEnvironment releaseApplicationEnvironment.
	self assert: LcsApplicationEnvironment singleton isNil.
	self assert: LcsObject hasNoninitializedApplicationEnvironment
]
