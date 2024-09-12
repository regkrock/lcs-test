Class {
	#name : #LcsStringSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsStringSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsStringSlot
]

{ #category : #'code generation' }
LcsStringSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
]
