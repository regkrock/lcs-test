Class {
	#name : #LcsStringSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #default }
LcsStringSlot >> defaultInitialValueBlaock [
	^ [ self typeClass new ]
]

{ #category : #initialize }
LcsStringSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #configuration }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
