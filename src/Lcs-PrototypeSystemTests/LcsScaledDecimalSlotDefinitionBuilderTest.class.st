Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #accessing }
LcsScaledDecimalSlotDefinitionBuilderTest >> testInstallingHeightSlotInPerson [
	| person |
	self slotName: 'height'.
	self initialValue: 180.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsIntegerSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]

{ #category : #accessing }
LcsScaledDecimalSlotDefinitionBuilderTest >> testInstallingWeightSlotInPerson [
	| person |
	self slotName: 'wegith'.
	self initialValue: 180.0s2.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsIntegerSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
