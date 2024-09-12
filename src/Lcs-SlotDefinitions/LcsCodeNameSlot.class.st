Class {
	#name : #LcsCodeNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsCodeNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'codeName'
]
