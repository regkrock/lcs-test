Class {
	#name : #LcsLibraryItem,
	#superclass : #LcsDomainObject,
	#instVars : [
		'libraryCategory',
		'itemName',
		'itemAuthors'
	],
	#classInstVars : [
		'collectionSlotName'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsLibraryItem class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsSecondaryCollectionSlot new
		slotName: 'authors';
		addSlotType: LcsAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #'slot definition' }
LcsLibraryItem class >> itemAuthorsSlotDefinition [
	<slotDefinition>
	^LcsSecondaryCollectionSlot new
		slotName: 'itemAuthors';
		addSlotType: LcsItemAuthors; 
		addCollectionMemberType: LcsAuthor;
		beOrderedCollection;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> itemNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'itemName';
		beRequired;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> librearyCategorySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'libraryCategory';
		collectionSlotName: 'libraryCategories';
		collectionModuleName: 'WarRabbitLibrary';
		beRequired;
		yourself
]

{ #category : #'instance  creation' }
LcsLibraryItem class >> newFor: line [ 
]

{ #category : #accessing }
LcsLibraryItem class >> newOn: aString parts: protoItemParts [ 
	^ self new
		initializeOn: aString parts: protoItemParts;
		yourself
]

{ #category : #'slot definition' }
LcsLibraryItem class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsWarRabbitLibrary moduleName;
		collectionSlotName: 'libraryItems';
		yourself
]

{ #category : #accessing }
LcsLibraryItem >> initializeOn: aString parts: protoItemParts [ 
	self 
		"originalLine: aString;
		parts: protoItemParts"
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors [
	^ self getValueOfSlotNamed: 'itemAuthors'
]

{ #category : #accessing }
LcsLibraryItem >> itemAuthors: anObject [
	self setValueOfSlotNamed: 'itemAuthors' to: anObject
]

{ #category : #accessing }
LcsLibraryItem >> itemName [
	^ self getValueOfSlotNamed: 'itemName'
]

{ #category : #accessing }
LcsLibraryItem >> itemName: anObject [
	self setValueOfSlotNamed: 'itemName' to: anObject
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory [
	^ self getValueOfSlotNamed: 'libraryCategory'
]

{ #category : #accessing }
LcsLibraryItem >> libraryCategory: anObject [
	self setValueOfSlotNamed: 'libraryCategory' to: anObject
]
