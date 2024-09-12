Class {
	#name : #LcsStringSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsStringSlotDefinitionBuilderTest >> testInstallingFirstNameSlotInPerson [
	| person |
	self slotName: 'firstName'.
	self initialValue: 'John'.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsStringSlotDefinitionBuilder.

	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
