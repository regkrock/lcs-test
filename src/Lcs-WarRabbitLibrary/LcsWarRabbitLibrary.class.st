Class {
	#name : #LcsWarRabbitLibrary,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'libraryCategories',
		'libraryItems',
		'authors'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsWarRabbitLibrary class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'authors';
		addSlotType: LcsAuthors; 
		addCollectionMemberType: LcsAuthor;
		yourself
]

{ #category : #'slot definition' }
LcsWarRabbitLibrary class >> libraryCategoriesSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'libraryCategories';
		addSlotType: LcsLibraryCategories; 
		addCollectionMemberType: LcsLibraryCategory;
		yourself
]

{ #category : #'slot definition' }
LcsWarRabbitLibrary class >> libraryItemsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlot new
		slotName: 'libraryItems';
		addSlotType: LcsLibraryItems; 
		addCollectionMemberType: LcsLibraryItem;
		yourself
]

{ #category : #accessing }
LcsWarRabbitLibrary >> authors [
	^ self getValueOfSlotNamed: 'authors'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> authors: anObject [
	self setValueOfSlotNamed: 'authors' to: anObject
]

{ #category : #'slot model' }
LcsWarRabbitLibrary >> initialSystemDomainClasses [
	<todo: 'Refactor to make this mor efficient'>
	^ super initialSystemDomainClasses
		add: LcsAuthor;
		add: LcsAuthors;
		add: LcsItemAuthors;
		add: LcsLibraryCategory;
		add: LcsLibraryCategories;
		add: LcsLibraryItem ;
		addAll: LcsLibraryItem subclasses;
		add: LcsLibraryItems;
		yourself
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryCategories [
	^ self getValueOfSlotNamed: 'libraryCategories'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryCategories: anObject [
	self setValueOfSlotNamed: 'libraryCategories' to: anObject
]

{ #category : #query }
LcsWarRabbitLibrary >> libraryCategoryFor: aString [
	^ self libraryCategories libraryCategoryFor: aString
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryItems [
	^ self getValueOfSlotNamed: 'libraryItems'
]

{ #category : #accessing }
LcsWarRabbitLibrary >> libraryItems: anObject [
	self setValueOfSlotNamed: 'libraryItems' to: anObject
]
