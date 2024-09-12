Class {
	#name : #LcsSingletonShortNameSlot,
	#superclass : #LcsShortNameSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialialize }
LcsSingletonShortNameSlot >> initialize [
	super initialize.
	self initialValueBlock: [ :domainClass | domainClass defaultShortName ]
]
