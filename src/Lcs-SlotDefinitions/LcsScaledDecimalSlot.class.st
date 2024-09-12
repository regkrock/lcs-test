Class {
	#name : #LcsScaledDecimalSlot,
	#superclass : #LcsNumberSlot,
	#instVars : [
		'numberOfDecimals'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsScaledDecimalSlot >> defaultInitialValueBlock [ 
	^ [ 0 asScaledDecimal: self numberOfDecimals ]
]

{ #category : #accessing }
LcsScaledDecimalSlot >> initialize [
	super initialize.
	self numberOfDecimals: 0
]

{ #category : #accessing }
LcsScaledDecimalSlot >> numberOfDecimals [
	^ numberOfDecimals
]

{ #category : #accessing }
LcsScaledDecimalSlot >> numberOfDecimals: anObject [
	numberOfDecimals := anObject
]

{ #category : #configuration }
LcsScaledDecimalSlot >> typeClass [
	^LcsSmalltalkConfiguration scaledDeciamlClass
]
