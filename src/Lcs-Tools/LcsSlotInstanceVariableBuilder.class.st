Class {
	#name : #LcsSlotInstanceVariableBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #building }
LcsSlotInstanceVariableBuilder >> installCode [
	self isInstanceVariableAlreadyCreated ifTrue: [ ^ self ].
	self refactoring: (RBAddInstanceVariableChange add: self slotName to: self target).
	self refactoring execute
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> isInstanceVariableAlreadyCreated [
	^ self slotBuilder isInstanceVariableAlreadyCreated
]

{ #category : #printing }
LcsSlotInstanceVariableBuilder >> jobStepActionDescription [
	^ 'Install instVar '
]

{ #category : #'gt views' }
LcsSlotInstanceVariableBuilder >> refactoringText [
	^ ([ self isInstanceVariableAlreadyCreated ] on: Error do: [ :s | false ])
		ifTrue: [ 'Use existing instanceVariable: ' , self slotName ]
		ifFalse: [ 'Add instanceVariable: ' , self slotName ]
]

{ #category : #verification }
LcsSlotInstanceVariableBuilder >> verifyCodeInstallation [
	self assert: (self target allInstVarNames includes: self slotName).
]
