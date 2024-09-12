Class {
	#name : #LcsSlotGetterAndSetterBuilder,
	#superclass : #LcsSlotDetailBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #'gt views' }
LcsSlotGetterAndSetterBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
]

{ #category : #building }
LcsSlotGetterAndSetterBuilder >> installCode [
	self refactoring: ( RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: self slotName
		class: self target).
	self refactoring execute
]

{ #category : #printing }
LcsSlotGetterAndSetterBuilder >> jobStepActionDescription [
	^ 'Install getter and setter for'
]

{ #category : #building }
LcsSlotGetterAndSetterBuilder >> protoGetterAndSetterRefactoring [
	^ RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: self slotName
		class: ([ self target ] on: Error do: [ :s | UndefinedClass ] )
]

{ #category : #'gt views' }
LcsSlotGetterAndSetterBuilder >> refactoringText [
	^ (WriteStream on: String new)
		nextPutAll: self protoGetterAndSetterRefactoring slotSetterMethodSource;
		cr;
		cr;
		nextPutAll: self protoGetterAndSetterRefactoring slotGetterMethodSource;
		contents
]

{ #category : #verification }
LcsSlotGetterAndSetterBuilder >> verifyCodeInstallation [
	self assert: (self target canUnderstand: self slotName asSymbol).
	self assert: (self target canUnderstand: (self slotName , ':') asSymbol).
]
