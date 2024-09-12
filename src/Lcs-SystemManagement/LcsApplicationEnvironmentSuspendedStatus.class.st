Class {
	#name : #LcsApplicationEnvironmentSuspendedStatus,
	#superclass : #LcsBaseApplicationEnvironmentStatus,
	#instVars : [
		'suspendedSystem'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #testing }
LcsApplicationEnvironmentSuspendedStatus >> isInSuspendedStatus [
	^ true
]

{ #category : #api }
LcsApplicationEnvironmentSuspendedStatus >> restoreApplicationEnvironment [
	self parent makeSystemCurrent: self suspendedSystem.
	self parent status: (LcsApplicationEnvironmentActiveStatus newOn: self parent)
]

{ #category : #accessing }
LcsApplicationEnvironmentSuspendedStatus >> statusName [
	^ 'Suspended' translated
]

{ #category : #accessing }
LcsApplicationEnvironmentSuspendedStatus >> suspendedSystem [
	^ suspendedSystem
]

{ #category : #accessing }
LcsApplicationEnvironmentSuspendedStatus >> suspendedSystem: anObject [
	suspendedSystem := anObject
]
