Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsScaledDecimalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsScaledDecimalSlot
]

{ #category : #'code generation' }
LcsScaledDecimalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
