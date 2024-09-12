Class {
	#name : #LcsModuleTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-Tests'
}

{ #category : #accessing }
LcsModuleTest >> setupSunitSystem [
	'LxxPrototypeSystem' asClass new
]

{ #category : #tests }
LcsModuleTest >> testAddingAModule [
	self assert: self currentSystem notNil.
	self assert: self currentSystem modules size = 2.
	self currentSystem installModule: LxxDemonstrationModule.
	self assert: self currentSystem modules size = 3.
	self assert: (( self currentSystem moduleNamed: LxxDemonstrationModule moduleName) isKindOf: LxxDemonstrationModule) 
]
