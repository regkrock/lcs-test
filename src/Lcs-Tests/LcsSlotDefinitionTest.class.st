Class {
	#name : #LcsSlotDefinitionTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #tests }
LcsSlotDefinitionTest >> testCreation [
	| slotDefinition |
	slotDefinition := LcsSlotDefintion new.
	self assert: slotDefinition slotTypes isEmpty.
	self assert: slotDefinition slotName isNil.
	slotDefinition slotName: #test.
	self assert: slotDefinition slotName equals: #test.
	slotDefinition addSlotType: Date.
	self assert: (slotDefinition slotTypes includes: Date)
]
