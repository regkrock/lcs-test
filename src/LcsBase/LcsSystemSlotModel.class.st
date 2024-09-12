Class {
	#name : #LcsSystemSlotModel,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'slotModels'
	],
	#category : #LcsBase
}

{ #category : #'instance creation' }
LcsSystemSlotModel class >> newOn: aSystem [ 
	^ self new
		parent: aSystem;
		yourself
]

{ #category : #'slot model' }
LcsSystemSlotModel >> addToSlotModel: aSlotModel [
	self slotModels at: aSlotModel parent put: aSlotModel
]

{ #category : #'gt view' }
LcsSystemSlotModel >> gtSystemSlotModelFor: aView [
	<gtView>
	self slotModels ifEmpty: [ ^ aView empty ].
	^ aView columnedTree 
		title: 'Slot Model';
		priority: 2.5;
		"expandUpTo: 0;"
		items: [ self gtViewSlotModelChildren ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each item displayString ];
		send: #item;
		yourself
]

{ #category : #'gt view' }
LcsSystemSlotModel >> gtViewSlotModelChildren [
	| children |
	children := OrderedCollection new.
	self slotModels keysAndValuesDo: [ :key :value |
		children add: (LcsSlotModelViewItem newLabel: key name item: value) ].
	^ children
]

{ #category : #testing }
LcsSystemSlotModel >> hasSlotModelFor: aClass [
	self slotModels at: aClass ifAbsent: [ ^ false ].
	^ true
]

{ #category : #testing }
LcsSystemSlotModel >> hasSlotModels [
	^ self slotModels notEmpty
]

{ #category : #initialize }
LcsSystemSlotModel >> initialize [
	super initialize.
	self slotModels: LcsSmalltalkConfiguration identityDictionaryClass new
]

{ #category : #accessing }
LcsSystemSlotModel >> parent [
	^ parent
]

{ #category : #accessing }
LcsSystemSlotModel >> parent: aSystem [ 
	parent := aSystem
]

{ #category : #'slot model' }
LcsSystemSlotModel >> restoreSlotModel [
	#LcsDomainObject asClass releaseApplicationEnvironment.
	self slotModels keysAndValuesDo: [ :eachDomainClass :eachSlotModel | eachDomainClass slotModel: eachSlotModel ]

]

{ #category : #accessing }
LcsSystemSlotModel >> slotModels [
	^ slotModels
]

{ #category : #accessing }
LcsSystemSlotModel >> slotModels: anObject [
	slotModels := anObject
]
