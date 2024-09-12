Class {
	#name : #LcsObjectChangeRecord,
	#superclass : #LcsObject,
	#instVars : [
		'domainObject',
		'parent'
	],
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #accessing }
LcsObjectChangeRecord class >> newFor: aDomainObject parent: anObject [
	^self new
		initializeFor: aDomainObject parent: anObject;
		yourself
]

{ #category : #api }
LcsObjectChangeRecord >> applyChanges [
	self subclassResponsibility
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject [
	^ domainObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> gtUnitOfWorkChildren [
	^ LcsUnitOfWorkViewItem newLabel: self viewItemLabel item: self domainObject
]

{ #category : #initialization }
LcsObjectChangeRecord >> initializeFor: aDomainObject parent: anObject [
	self 
		domainObject: aDomainObject;
		parent: anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self domainObject isMemberOfGlobalCollectionIn: aSlotName
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent [
	^ parent
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent: anObject [
	parent := anObject
]
