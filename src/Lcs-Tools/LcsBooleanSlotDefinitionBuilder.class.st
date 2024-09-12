Class {
	#name : #LcsBooleanSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsBooleanSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsBooleanSlot
]

{ #category : #'code generation' }
LcsBooleanSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
