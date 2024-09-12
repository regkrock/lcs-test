Class {
	#name : #LcsUnitOfWork,
	#superclass : #LcsBaseUnitOfWork,
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #api }
LcsUnitOfWork >> applyChanges [
	self addedObjects valuesDo: [ :each | each applyChanges ].
	self changedObjects do: [ :each | each applyChanges ].
	self clearUnitOfWork
]

{ #category : #api }
LcsUnitOfWork >> changedSlotRecordFor: aDomainObject slotNamed: aSlotName [
	^ (self changedRecordFor: aDomainObject)
		ifNil: [ nil ]
		ifNotNil: [ :changedObjectRecord | changedObjectRecord changedSlotRecordFor: aSlotName ]
]

{ #category : #testing }
LcsUnitOfWork >> hasChanges [
	self changedObjects notEmpty ifTrue: [ ^ true ].
	self deletedObjects notEmpty ifTrue: [ ^ true ].
	^ self addedObjects notEmpty
]

{ #category : #testing }
LcsUnitOfWork >> hasNoChanges [
	self changedObjects isEmpty ifTrue: [ ^ true ].
	self deletedObjects isEmpty ifTrue: [ ^ true ].
	^ self addedObjects isEmpty
]

{ #category : #query }
LcsUnitOfWork >> pendingAddsFor: anItem [
	^ self addedObjects
		select: [ :eachAddRecord | 
			eachAddRecord isMemberOfGlobalCollectionIn: anItem label ]
]

{ #category : #query }
LcsUnitOfWork >> pendingRmovalsFor: anItem [
	^ self deletedObjects
		select: [ :eachDeletedRecord | 
			eachDeletedRecord isMemberOfGlobalCollectionIn: anItem label ]
]
