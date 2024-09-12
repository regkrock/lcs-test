Class {
	#name : #LcsBaseApplicationEnvironmentTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'currentApplicationEnvironment'
	],
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsBaseApplicationEnvironmentTest >> currentApplicationEnvironment [
	^currentApplicationEnvironment
]

{ #category : #acccessing }
LcsBaseApplicationEnvironmentTest >> currentApplicationEnvironment: anApplicationEnvironment [ 
	currentApplicationEnvironment := anApplicationEnvironment
]

{ #category : #running }
LcsBaseApplicationEnvironmentTest >> setUp [
	self abortTransaction. 
	super setUp.
	self currentApplicationEnvironment: LcsApplicationEnvironment suspendCurrentApplicationEnvironment.
	self commitTransaction
]

{ #category : #running }
LcsBaseApplicationEnvironmentTest >> tearDown [
	self abortTransaction. 
	super tearDown.
	LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: self currentApplicationEnvironment.
	LcsApplicationEnvironment hasInitializedApplicationEnvironment ifTrue: [
	self assert: LcsApplicationEnvironment isInActiveStatus].
	self commitTransaction
]
