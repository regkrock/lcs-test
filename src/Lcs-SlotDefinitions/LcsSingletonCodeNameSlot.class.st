Class {
	#name : #LcsSingletonCodeNameSlot,
	#superclass : #LcsCodeNameSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsSingletonCodeNameSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :domainClass | domainClass defaultCodeName ]
]
