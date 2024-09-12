Class {
	#name : #LcsBooleanSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ false ]
]

{ #category : #configuration }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
