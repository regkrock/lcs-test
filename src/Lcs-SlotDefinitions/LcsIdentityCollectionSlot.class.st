Class {
	#name : #LcsIdentityCollectionSlot,
	#superclass : #LcsCollectionSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #iniitialize }
LcsIdentityCollectionSlot >> typeClass [
	^ IdentitySet 
]
