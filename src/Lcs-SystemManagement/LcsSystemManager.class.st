Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'systems',
		'currentSystem'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'instance creation' }
LcsSystemManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement
]

{ #category : #'instance creation' }
LcsSystemManager class >> newOn: anAppicaltionEnvironment [
	^ self basicNew 
		initialize;
		initializeOn: anAppicaltionEnvironment;
		yourself
]

{ #category : #accessing }
LcsSystemManager >> applicationEnvironment [
	^self parent applicationEnvironment
]

{ #category : #'gt view' }
LcsSystemManager >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current System' item: self currentSystem.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Running Systems' item: self systems.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Available Systems' item: '' "self availableSystemClasses". }
]

{ #category : #'gt view' }
LcsSystemManager >> applicationEnvironmentViewaAvailableSystemsChildren [
	^ self availableSystemClasses
		collect: [ :eachClass | LcsApplicationEnvironmentViewItem newOn: self label: eachClass name item: eachClass ]
]

{ #category : #accessing }
LcsSystemManager >> createCurrentSystemFor: aSystemClass [.
	self suspendCurrentSystem.
	self currentSystem: aSystemClass basicNew.
	self currentSystem initializeInNewUnitOfWork: self.
	self systems add: self currentSystem.
	^ self currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem [
	^ currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : #querry }
LcsSystemManager >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #'gt view' }
LcsSystemManager >> gtAllSystemsFor: aView [
	<gtView>
	^ aView columnedTree 
		title: 'Systems';
		priority: 2.5;
		expandUpTo: 3;
		items: [ {LcsApplicationEnvironmentViewItem newOn: self label: 'System Manager' item: self} ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each item displayString ];
		send: #item;
		yourself
]

{ #category : #accessing }
LcsSystemManager >> gtSystemManagerFor: aView [
		<gtView>
	^ aView columnedList
		title: 'System Manager';
		priority: 10;
		items: [ { 
					'Initialized' -> true.
					'Current System' -> self currentSystem .
					'Current Unit Of Work' -> self unitsOfWorkManager currentUnitOfWork.
					'Number Of Systems' -> self numberOfSystems.
					'Systems' -> self systems collection} ];
		column: 'Option' text: #key width: 200;
		column: 'Value' text: #value;
		send: #value;
		yourself
		
]

{ #category : #testing }
LcsSystemManager >> hasCurrentSystem [
	^ self currentSystem notNil
]

{ #category : #testing }
LcsSystemManager >> hasNoCurrentSystem [
	^ self currentSystem isNil
]

{ #category : #initialize }
LcsSystemManager >> initialize [
	super initialize.
	self systems: (LcsSystems newOn: self)
]

{ #category : #initialize }
LcsSystemManager >> initializeOn: anAppicaltionEnvironment [ 
	self parent: anAppicaltionEnvironment 
]

{ #category : #api }
LcsSystemManager >> makeSystemCurrent: aSystem [
	self currentSystem: aSystem.
	self currentSystem 
		ifNil: [  self releaseSlotModel ]
		ifNotNil: [ self currentSystem restoreSystem ]
]

{ #category : #querry }
LcsSystemManager >> numberOfSystems [
	^ self systems size
]

{ #category : #accessing }
LcsSystemManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsSystemManager >> parent: anObject [
	parent := anObject
]

{ #category : #api }
LcsSystemManager >> releaseApplicationEnvironment [
	self removeCurrentSystem.
	self systems: OrderedCollection new
]

{ #category : #api }
LcsSystemManager >> releaseSlotModel [
	#LcsDomainObject asClass releaseSlotModel
]

{ #category : #api }
LcsSystemManager >> removeCurrentSystem [
	self removeSystem: self currentSystem
]

{ #category : #api }
LcsSystemManager >> removeSystem: aSystem [
	self releaseSlotModel.
	self unitsOfWorkManager removeUnitsOfWorkFor: aSystem.
	self systems remove: aSystem ifAbsent: [ ].
	aSystem == self currentSystem ifTrue: [ self currentSystem: nil ]
]

{ #category : #api }
LcsSystemManager >> restoreSlotModel [
	#LcsDomainObject asClass restoreSlotModel
]

{ #category : #api }
LcsSystemManager >> restoreUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager restoreUnitOfWorkFor: suspendedSystem
]

{ #category : #api }
LcsSystemManager >> suspendCurrentSystem [
	| suspendedSystem |
	suspendedSystem := self currentSystem.
	suspendedSystem ifNotNil: [ suspendedSystem suspendSystem ].
	self currentSystem: nil.
	^ suspendedSystem
]

{ #category : #api }
LcsSystemManager >> suspendUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager suspendUnitOfWorkFor: suspendedSystem
]

{ #category : #accessing }
LcsSystemManager >> systems [
	^ systems
]

{ #category : #accessing }
LcsSystemManager >> systems: anObject [
	systems := anObject
]

{ #category : #accessing }
LcsSystemManager >> unitsOfWorkManager [
	^ self parent unitsOfWorkManager
]
