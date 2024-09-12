Class {
	#name : #LcsSlotDetailBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'refactoring'
	],
	#category : #'Lcs-Tools'
}

{ #category : #printing }
LcsSlotDetailBuilder >> jobStepActionDescription [
	^ 'Install instVar'
]

{ #category : #printing }
LcsSlotDetailBuilder >> jobStepDescription [
	^ (WriteStream on: String new)
		nextPutAll: self stepNumber;
		nextPutAll: ') ';
		nextPutAll: self jobStepActionDescription;
		nextPutAll: ' "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: self slotBuilder targetClassName;
		contents
]

{ #category : #accessing }
LcsSlotDetailBuilder >> jobSteps [
	^ LcsCodeBuilderJobSteps new
]

{ #category : #building }
LcsSlotDetailBuilder >> refactoring [
	^ refactoring
]

{ #category : #building }
LcsSlotDetailBuilder >> refactoring: anObject [ 
	refactoring := anObject
]

{ #category : #building }
LcsSlotDetailBuilder >> slotBuilder [
	^ self parent parent
]

{ #category : #building }
LcsSlotDetailBuilder >> slotDefinitionSource [
	^ self slotBuilder slotDefinitionSource
]

{ #category : #building }
LcsSlotDetailBuilder >> slotName [
	^ self slotBuilder slotName
]

{ #category : #printing }
LcsSlotDetailBuilder >> stepNumber [
	| stepNumber |
	stepNumber := (self parent indexOf: self) printString.
	^ self slotBuilder addStepNumberTo: stepNumber
]

{ #category : #building }
LcsSlotDetailBuilder >> target [
	^ self slotBuilder target
]

{ #category : #verification }
LcsSlotDetailBuilder >> verifyCodeInstallation [
]

{ #category : #verification }
LcsSlotDetailBuilder >> verifySlotModelUpdates [
]
