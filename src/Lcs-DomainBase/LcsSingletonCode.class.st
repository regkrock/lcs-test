Class {
	#name : #LcsSingletonCode,
	#superclass : #LcsCode,
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot definitions' }
LcsSingletonCode class >> codeDescriptionSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> codeNameSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeNameSlot new
]

{ #category : #defaults }
LcsSingletonCode class >> defaultCodeDescription [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSingletonCode class >> defaultCodeName [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSingletonCode class >> defaultInstance [
	^ false
]

{ #category : #defaults }
LcsSingletonCode class >> defaultShortName [
	self subclassResponsibility
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ super isDefaultInstanceSlotDefinition
		initialValueBlock: [ :codeClass | codeClass  defaultInstance ]; 
		yourself
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsSingletonShortNameSlot new
]
