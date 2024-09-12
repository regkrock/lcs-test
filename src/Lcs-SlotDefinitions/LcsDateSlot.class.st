Class {
	#name : #LcsDateSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsDateSlot >> defaultInitialValueBlock [ 
	^ [ Date today ]
]

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
