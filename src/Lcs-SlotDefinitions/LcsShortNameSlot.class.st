Class {
	#name : #LcsShortNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsShortNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'shortName'
]
