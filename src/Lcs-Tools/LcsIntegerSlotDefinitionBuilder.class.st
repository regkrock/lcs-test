Class {
	#name : #LcsIntegerSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsIntegerSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsIntegerSlot
]

{ #category : #'code generation' }
LcsIntegerSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
