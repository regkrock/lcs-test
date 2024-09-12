Class {
	#name : #LcsAuthor,
	#superclass : #LcsDomainObject,
	#instVars : [
		'surname',
		'firstName',
		'middleNames',
		'authorship'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definition' }
LcsAuthor class >> authorshipSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'authorship';
		addSlotType: LcsLibraryItems; 
		addCollectionMemberType: LcsLibraryItem;
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> fristNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		beRequired;
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> middleNamesSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'middleNames';
		beOptional;
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsWarRabbitLibrary moduleName;
		collectionSlotName: 'authors';
		yourself
]

{ #category : #'slot definition' }
LcsAuthor class >> surnameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'surname';
		beRequired;
		yourself
]

{ #category : #accessing }
LcsAuthor >> authorship [
	^ self getValueOfSlotNamed: 'authorship'
]

{ #category : #accessing }
LcsAuthor >> authorship: anObject [
	self setValueOfSlotNamed: 'authorship' to: anObject
]

{ #category : #accessing }
LcsAuthor >> firstName [
	^ self getValueOfSlotNamed: 'firstName'
]

{ #category : #accessing }
LcsAuthor >> firstName: anObject [
	self setValueOfSlotNamed: 'firstName' to:anObject
]

{ #category : #accessing }
LcsAuthor >> middleNames [
	^ self getValueOfSlotNamed: 'middleNames'
]

{ #category : #accessing }
LcsAuthor >> middleNames: anObject [
	self setValueOfSlotNamed: 'middleNames' to: anObject
]

{ #category : #accessing }
LcsAuthor >> surname [
	^ self getValueOfSlotNamed: 'surname'
]

{ #category : #accessing }
LcsAuthor >> surname: anObject [
	self setValueOfSlotNamed: 'surname' to: anObject
]
