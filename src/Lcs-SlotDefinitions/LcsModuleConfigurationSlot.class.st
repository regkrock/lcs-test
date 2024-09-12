Class {
	#name : #LcsModuleConfigurationSlot,
	#superclass : #LcsCompositeSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsModuleConfigurationSlot class >> newOn: aConfigurationClass [
	^ self new
		initializeOn: aConfigurationClass
		yourself
]

{ #category : #accessing }
LcsModuleConfigurationSlot >> initialize [
	super initialize.
	self slotName: 'configuration'
]

{ #category : #accessing }
LcsModuleConfigurationSlot >> initializeOn: aConfigurationClass [ 
	self addSlotType: aConfigurationClass
]
