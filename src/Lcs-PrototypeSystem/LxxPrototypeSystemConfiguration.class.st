Class {
	#name : #LxxPrototypeSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototypeSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefintion new
		slotName: 'parent';
		yourself
]
