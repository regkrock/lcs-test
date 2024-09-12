Class {
	#name : #LcsSystemTest,
	#superclass : #LcsSystemTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #tests }
LcsSystemTest >> testCreation [

	| currentUnitOfWork system |

	LcsApplicationEnvironment removeCurrentSystem.
	self assert: self currentSystem isNil. 
	system := LcsMainSystem new.
	self assert: self currentSystem notNil.

	currentUnitOfWork := self currentSystem currentUnitOfWork.
	self assert: LcsApplicationEnvironment unitsOfWorkManager  unitsOfWork notEmpty. 
	self assert: currentUnitOfWork notNil.
	self assert: currentUnitOfWork system identicalTo: self currentSystem.
	self assert: self currentSystem notNil.
	self assert: (LcsPerson slotDefinitionNamed: #dateOfBirth) slotName equals: #dateOfBirth.
	self assert: (self currentSystem moduleNamed: LcsGeographyModule moduleName) notNil
]
