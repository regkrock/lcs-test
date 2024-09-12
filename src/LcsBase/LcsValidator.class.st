Class {
	#name : #LcsValidator,
	#superclass : #LcsObject,
	#instVars : [
		'validatedObjects',
		'validationErrors',
		'validationIssues',
		'visitationStack'
	],
	#category : #LcsBase
}

{ #category : #validation }
LcsValidator >> addIssueMessage: aString [
	self validationIssues
		add: (LcsValidatorIssueMessage newOn: self objectBeingValidated message: aString)
]

{ #category : #testing }
LcsValidator >> hasAlreadyBeenValidated: anObject [
	^ self validatedObjects includes: anObject
]

{ #category : #testing }
LcsValidator >> hasNoValidationIssues [
	^ self validationIssues isEmpty
]

{ #category : #testing }
LcsValidator >> hasValidationIssues [
	^ self validationIssues notEmpty
]

{ #category : #initiailize }
LcsValidator >> initialize [
	super initialize.
	self visitationStack: OrderedCollection new.
	self validatedObjects: OrderedCollection new.
	self validationIssues: OrderedCollection new
]

{ #category : #validation }
LcsValidator >> objectBeingValidated [
	^ self validatedObjects last
]

{ #category : #validation }
LcsValidator >> objectBeingValidated: anObject [
	self visitationStack add: anObject.
	self validatedObjects add: anObject
]

{ #category : #api }
LcsValidator >> validate: anObject [
	(self hasAlreadyBeenValidated: anObject) ifTrue: [ ^ self ].
	[ 
		self objectBeingValidated: anObject.
		self validateCurrentObject 
	] 
		ensure: [ self visitationStack removeLast ]
]

{ #category : #validation }
LcsValidator >> validateCurrentObject [
	self subclassResponsibility
]

{ #category : #accessing }
LcsValidator >> validatedObjects [
	^ validatedObjects
]

{ #category : #accessing }
LcsValidator >> validatedObjects: anObject [
	validatedObjects := anObject
]

{ #category : #accessing }
LcsValidator >> validationIssues [
	^ validationIssues
]

{ #category : #accessing }
LcsValidator >> validationIssues: anObject [ 
	validationIssues := anObject
]

{ #category : #accessing }
LcsValidator >> visitationStack [
	^ visitationStack
]

{ #category : #accessing }
LcsValidator >> visitationStack: anObject [
	visitationStack := anObject
]
