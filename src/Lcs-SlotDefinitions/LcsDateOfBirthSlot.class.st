Class {
	#name : #LcsDateOfBirthSlot,
	#superclass : #LcsDateSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'
]
