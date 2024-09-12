Class {
	#name : #LcsSlotDefintionMethodBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #'gt v' }
LcsSlotDefintionMethodBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #building }
LcsSlotDefintionMethodBuilder >> installCode [
	self refactoring: (RBAddMethodChange
				compile: self slotDefinitionSource
				in: self target class
				classified: #'slot definitions').
	self refactoring execute
]

{ #category : #printing }
LcsSlotDefintionMethodBuilder >> jobStepActionDescription [
	^ 'Install slot definition for'
]

{ #category : #'gt v' }
LcsSlotDefintionMethodBuilder >> refactoringText [
	^ self slotDefinitionSource
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifyCodeInstallation [
	self assert: (self target class canUnderstand: self slotBuilder slotDefinitionSelector)
]

{ #category : #verification }
LcsSlotDefintionMethodBuilder >> verifySlotModelUpdates [
	self assert: (self target slotModel slotDefinitionNamed: self slotName) notNil
]
