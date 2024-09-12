Class {
	#name : #LcsSystemManagerTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testCreateUnitOfWork [
	LcsApplicationEnvironment releaseApplicationEnvironment.
	LcsApplicationEnvironment initializeApplicationEnvironment.

	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.
	LcsApplicationEnvironment createUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork class identicalTo: LcsUnitOfWork 
]

{ #category : #tests }
LcsSystemManagerTest >> testRemoveCurrentSystem [
	LcsApplicationEnvironment releaseApplicationEnvironment.
	LcsApplicationEnvironment initializeApplicationEnvironment.

	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

	LcsApplicationEnvironment currentSystem: 'example'.
	self assert: LcsApplicationEnvironment currentSystem equals: 'example'.
	
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

]

{ #category : #accessing }
LcsSystemManagerTest >> testRemoveCurrentUnitOfWork [
	LcsApplicationEnvironment releaseApplicationEnvironment.
	LcsApplicationEnvironment initializeApplicationEnvironment.

	LcsApplicationEnvironment removeCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil
]
