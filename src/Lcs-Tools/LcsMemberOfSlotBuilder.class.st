Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'moduleName',
		'slotTypes',
		'targetModuleName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #deafult }
LcsMemberOfSlotBuilder class >> slotDefinitionClass [
	^ LcsMemberOfSlot
]

{ #category : #'code generation' }
LcsMemberOfSlotBuilder >> addSlotDefinitionSourceDetailsTo: codeStream [
	self slotTypes do: [ :eachSlotTypeClass |
		codeStream addSetter: 'addSlotType' contents: eachSlotTypeClass name].
	codeStream
		addSetter: 'collectionSlotName' contents: self collectionSlotName printString;
		addSetter: 'collectionModuleName' contents: self targetModuleName printString
.
	
]

{ #category : #configuration }
LcsMemberOfSlotBuilder >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #initialize }
LcsMemberOfSlotBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> moduleName [
	^ moduleName ifNil: [ self targertModuleClass ifNil: [ ' missing moduleClass name' ] ifNotNil: [  self targertModuleClass moduleName ] ] 
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName := self targetModuleClass moduleName ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> targetModuleName: anObject [
	moduleName := anObject
]
