Class {
	#name : #LcsValidatorIssueMessage,
	#superclass : #Object,
	#instVars : [
		'context',
		'message'
	],
	#category : #LcsBase
}

{ #category : #'instace creation' }
LcsValidatorIssueMessage class >> newOn: anObject message: aString [
	^ self new 
		initializeOn: anObject message: aString;
		yourself
]

{ #category : #accessing }
LcsValidatorIssueMessage >> context [
	^ context
]

{ #category : #accessing }
LcsValidatorIssueMessage >> context: anObject [
	context := anObject
]

{ #category : #'instace creation' }
LcsValidatorIssueMessage >> initializeOn: anObject message: aString [ 
	self 
		context: anObject;
		message: aString
]

{ #category : #accessing }
LcsValidatorIssueMessage >> message [
	^ message
]

{ #category : #accessing }
LcsValidatorIssueMessage >> message: anObject [
	message := anObject
]
