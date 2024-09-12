Class {
	#name : #LcsGlobalCollectionReferenceSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionSlotModuleName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsGlobalCollectionReferenceSlotBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionReferenceSlot
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	aCodeStream 
		addSetter: 'collectionSlotName' contents: self collectionSlotName printString;
		addSetter: 'collectionSlotModuleName' contents: self collectionSlotModuleName printString.
	

]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModuleName: aString [
	collectionSlotModuleName := aString
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : #initialize }
LcsGlobalCollectionReferenceSlotBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]
