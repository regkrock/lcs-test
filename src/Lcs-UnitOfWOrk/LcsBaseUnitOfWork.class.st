Class {
	#name : #LcsBaseUnitOfWork,
	#superclass : #LcsObject,
	#instVars : [
		'addedObjects',
		'changedObjects',
		'deletedObjects',
		'system',
		'unitOfWorkName'
	],
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #'instance creation' }
LcsBaseUnitOfWork class >> newOn: aSystem [ 
	^self new
		initializeOn: aSystem;
		yourself
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject [

	self addedObjects at: aDomainObject put: (LcsAddedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject context: aDomainContextObject [
	self addedObjects
		at: aDomainObject
		put: ((LcsAddedObjectRecord newFor: aDomainObject parent: self)
				creationContext: aDomainContextObject;
				yourself)
]

{ #category : #api }
LcsBaseUnitOfWork >> addRecordFor: aDomainObject [
	^ self addedObjects at: aDomainObject
]

{ #category : #accessing }
LcsBaseUnitOfWork >> addedObjects [
	^ addedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> addedObjects: anObject [
	addedObjects := anObject
]

{ #category : #api }
LcsBaseUnitOfWork >> applyChanges [
	self addedObjects valuesDo: [ :each | each applyChanges ].
	self changedObjects do: [ :each | each applyChanges ]
]

{ #category : #accessing }
LcsBaseUnitOfWork >> changedObjects [
	^ changedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> changedObjects: anObject [
	changedObjects := anObject
]

{ #category : #api }
LcsBaseUnitOfWork >> changedRecordFor: aDomainObject [
	^ (self changedObjects at: aDomainObject ifAbsent: [ nil ])
]

{ #category : #api }
LcsBaseUnitOfWork >> changedSlot: aSlotName valueTo: anObject in: aDomainObject [

	(self addedObjects keys includes: aDomainObject) ifTrue: [ ^ self ].
	(self changedObjects at: anObject ifAbsentPut: [ LcsChangedObjectRecord newFor: aDomainObject parent: self ])
		changedSlot: aSlotName valueTo: anObject
		
]

{ #category : #initialize }
LcsBaseUnitOfWork >> clearUnitOfWork [

	self addedObjects removeAll.
	self changedObjects removeAll.
	self deletedObjects removeAll
]

{ #category : #api }
LcsBaseUnitOfWork >> deleteObject: aDomainObject [
	self deletedObjects at: aDomainObject put: (LcsDeletedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects [
	^ deletedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects: anObject [
	deletedObjects := anObject
]

{ #category : #'gt view' }
LcsBaseUnitOfWork >> gtUnitOfWorkChildren [
	^ {
		LcsUnitOfWorkViewItem newLabel: 'Added' item: self addedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Changed' item: self changedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Deleted' item: self deletedObjects values.
		}
]

{ #category : #'gt view' }
LcsBaseUnitOfWork >> gtUnitOfWorkFor: aView [
	<gtView>
	^ aView columnedTree 
		title: 'Unit Of Work';
		priority: 2.5;
		expandUpTo: 1;
		items: [ self gtUnitOfWorkItems ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each gtItemDisplayString ];
		send: #item;
		yourself
]

{ #category : #'gt view' }
LcsBaseUnitOfWork >> gtUnitOfWorkItems [
	^ {
		LcsUnitOfWorkViewItem newLabel: 'Unit Of Work' item: self.
		LcsUnitOfWorkViewItem newLabel: 'Added' item: self addedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Changed' item: self changedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Deleted' item: self deletedObjects values.
		}
]

{ #category : #initialize }
LcsBaseUnitOfWork >> initialize [
	super initialize.
	self addedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self changedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self deletedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self clearUnitOfWork
]

{ #category : #initialize }
LcsBaseUnitOfWork >> initializeOn: aSystem [ 
	self system: aSystem
]

{ #category : #accessing }
LcsBaseUnitOfWork >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self system printString;
		nextPutAll: ')'
]

{ #category : #api }
LcsBaseUnitOfWork >> setValueTo: anObject in: aDomainObject forSlot: aSlotDefiniton [ 

	(self addedObjects keys includes: aDomainObject) ifTrue: [ 
		anObject isDomainObject ifTrue: [
			(anObject instVarNamed: 'parent') ifNil: [ anObject instVarNamed: 'parent' put: aDomainObject ] ].
		aDomainObject instVarNamed: aSlotDefiniton slotName asString put: anObject.
		^ self ].
	(self changedObjects at: aDomainObject ifAbsentPut: [ LcsChangedObjectRecord newFor: aDomainObject parent: self ])
		changedSlot: aSlotDefiniton slotName valueTo: anObject
		
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system [
	^ system
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system: aSystem [ 
	system := aSystem	
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName [
	^ unitOfWorkName
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName: anObject [
	unitOfWorkName := anObject
]
