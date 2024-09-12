"
Tests inheriting from this class have the current 'System' saved in the #setUP and it will be restored in the #tearDown phase.
"
Class {
	#name : #LcsDomainTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'savedSystem'
	],
	#category : #'Lcs-Tests'
}

{ #category : #'application environment' }
LcsDomainTest >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsDomainTest >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #accessing }
LcsDomainTest >> savedSystem [
	^ savedSystem
]

{ #category : #accessing }
LcsDomainTest >> savedSystem: aSystem [
	savedSystem := aSystem
]

{ #category : #running }
LcsDomainTest >> setUp [
	super setUp.
	self abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
	self setupSunitSystem.
	self commitTransaction
]

{ #category : #running }
LcsDomainTest >> setupSunitSystem [
	"subclasses can override this method to create the system required for testing"
]

{ #category : #'application environment' }
LcsDomainTest >> systemManager [
	^ LcsApplicationEnvironment systemManager
]

{ #category : #running }
LcsDomainTest >> tearDown [
	super tearDown.
	self abortTransaction.
	LcsApplicationEnvironment restoreToCurrent: self savedSystem. 
	self currentSystem notNil ifTrue: [
		self assert: self currentSystem identicalTo: self savedSystem ].
	self commitTransaction.

]

{ #category : #'application environment' }
LcsDomainTest >> unitsOfWorkManager [
	^ LcsApplicationEnvironment unitsOfWorkManager
]
