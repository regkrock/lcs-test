Class {
	#name : #LcsGeographyModuleTest,
	#superclass : #LcsSystemTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #tests }
LcsGeographyModuleTest >> testCreation [
	| module |
	module := self currentSystem geographyModule.
	self assert: (module isKindOf: LcsGeographyModule).
	self assert: (module slotDefinitionNamed: 'countries') notNil.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: (module countries isKindOf: LcsCountries).
	self assert: (module countries collection isKindOf: LcsSmalltalkConfiguration identitySetClass).
	self assert: module countries hasNoElements.
	
]
