"
This is the root class for application classes and tool and general utitlity classes.

Another root class is LcsTestCase - all test case classes should inherit from there
"
Class {
	#name : #LcsObject,
	#superclass : #Object,
	#instVars : [
		'globalCollectionClassName'
	],
	#category : #LcsBase
}

{ #category : #transactions }
LcsObject class >> abortTransaction [
	System abortTransaction
]

{ #category : #transactions }
LcsObject class >> commitTransaction [
	System commitTransaction
]

{ #category : #'application environment' }
LcsObject class >> currentSystem [

	^ #LcsApplicationEnvironment asClass currentSystem
]

{ #category : #private }
LcsObject class >> domainObjectClass [
	"This is done for packaging loading purposes"
	^ self subclasses detect: [ :each | each name = #LcsDomainObject ] ifNone: [ nil ]
]

{ #category : #testing }
LcsObject class >> hasNoninitializedApplicationEnvironment [
	^ self hasNoninitializedSlotModel
]

{ #category : #testing }
LcsObject class >> hasNoninitializedSlotModel [
	^ self domainObjectClass
		ifNil: [ true ]
		ifNotNil: [ :domainObjectClass | domainObjectClass hasNoninitializedApplicationEnvironment ]
]

{ #category : #testing }
LcsObject class >> initializeApplicationEnvironment [
	self domainObjectClass
		ifNotNil: [ :domainObjectClass | domainObjectClass initializeApplicationEnvironment ]
]

{ #category : #testing }
LcsObject class >> isApplicationSystemClass [
	^ false
]

{ #category : #testing }
LcsObject class >> isDomainClass [
	^ false
]

{ #category : #testing }
LcsObject class >> releaseApplicationEnvironment [
	self domainObjectClass
		ifNotNil: [ :domainObjectClass | domainObjectClass releaseApplicationEnvironment ]
]

{ #category : #accessing }
LcsObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #testing }
LcsObject >> isApplicationSystem [
	^ false
]

{ #category : #printing }
LcsObject >> printOn: aStream [
	super printOn: aStream.
	"aStream 
		nextPutAll: ' (objectId: ';
		nextPutAll: self hash displayString;
		nextPutAll: ')'"

]

{ #category : #accessing }
LcsObject >> tempMethod [
	^'Hello'
]

{ #category : #accessing }
LcsObject >> testGemstone [
	^1 = 2
]
