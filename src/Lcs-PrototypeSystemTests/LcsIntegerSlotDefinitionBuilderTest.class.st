Class {
	#name : #LcsIntegerSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsIntegerSlotDefinitionBuilderTest >> testCreatingIntegerSlotDefinition [
	| slotDefinition |

		slotDefinition := LcsIntegerSlot new.
	slotDefinition slotName: 'height'.
	slotDefinition initialValue: 180.

	self assert: slotDefinition domainClassName = 'UndefinedObject'.
	self assert: slotDefinition slotName equals: 'height'.
	self assert: slotDefinition slotTypes size equals: 1.
	self assert: (slotDefinition slotTypes includes: Integer).
	self assert: slotDefinition isNotRequired.
	self assert: slotDefinition initialValue equals: 180 
]

{ #category : #tests }
LcsIntegerSlotDefinitionBuilderTest >> testInstallingHeightSlotInPerson [
	| person |
	self slotName: 'height'.
	self initialValue: 180.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsIntegerSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
