Class {
	#name : #LcsBaseApplicationEnvironmentStatus,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'instance creation' }
LcsBaseApplicationEnvironmentStatus class >> newOn: anApplicationEnvironment [ 
	^ self new
		initializeOn: anApplicationEnvironment;
		yourself
]

{ #category : #initialize }
LcsBaseApplicationEnvironmentStatus >> initializeOn: anApplicationEnvironment [ 
	self parent: anApplicationEnvironment
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInActiveStatus [
	^ false
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInSuspendedStatus [
	^ false
]

{ #category : #accessing }
LcsBaseApplicationEnvironmentStatus >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseApplicationEnvironmentStatus >> parent: anApplicationEnvironment [ 
	parent := anApplicationEnvironment
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> restoreApplicationEnvironment [
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> suspendApplicationEnvironment [
]
