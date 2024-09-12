Class {
	#name : #LcsApplicationEnvironment,
	#superclass : #LcsObject,
	#instVars : [
		'systemManager',
		'unitsOfWorkManager',
		'status'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentDo: aBlock [
	^ self currentApplicationEnvironment ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentDoesNotHave: aBlock [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentHas: aBlock [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: aBlock 
]

{ #category : #'application environment - private' }
LcsApplicationEnvironment class >> applicationEnvironmentObject: aBlock [
	^ self currentApplicationEnvironment ifNil: [ nil ] ifNotNil: aBlock 
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Initialized' item: self currentApplicationEnvironment notNil.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current' item: self currentApplicationEnvironment}
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> createCurrentSystemFor: aSystemClass [ 
	self verifyApplicationEnvironment.
	^ self applicationEnvironmentDo: [ :env | env createCurrentSystemFor: aSystemClass ]
	
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> createUnitOfWork [
	^ self applicationEnvironmentDo: [ :env | env createUnitOfWork ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> currentApplicationEnvironment [
	^ LcsApplicationEnvironment singleton
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> currentSystem [
	^ self applicationEnvironmentObject: [ :env | env currentSystem ]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> currentSystem: aSystem [ 
	self applicationEnvironmentDo: [  :env | env currentSystem: aSystem ]
]

{ #category : #'unit of work' }
LcsApplicationEnvironment class >> currentUnitOfWork [
	^ self applicationEnvironmentObject: [ :env | env currentUnitOfWork ]
]

{ #category : #running }
LcsApplicationEnvironment class >> ensureInitialized [
	self hasInitializedApplicationEnvironment ifFalse: [ self initializeApplicationEnvironment ].
]

{ #category : #'gt views' }
LcsApplicationEnvironment class >> gtApplicationEnvironmentFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedTree
		title: 'Application Environment';
		priority: 1;
		expandUpTo: 4;
		items: [ self applicationEnvironmentViewChildren ];
		children: [ :each | each children ];
		column: 'Option' translated
			text: [ :each | each label displayString ]
			width: 200;
		column: 'Value' translated text: [ :each | each item displayString ] width: 300;
		column: '' stencil: [ :viewItem | viewItem actionButton] width: 70;
		column: '' stencil: [ :viewItem | viewItem action2Button] width: 70; 
		send: #item;
		actionUpdateButton;
		yourself
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasCurrentSystem [
	^ self applicationEnvironmentDoesNotHave: [ :env | env currentSystem notNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasCurrentUnitOfWork [
	^ self applicationEnvironmentHas: [:env |  env hasCurrentUnitOfWork ]
	"^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [:env |  self currentApplicationEnvironment hasCurrentUnitOfWork ]"
	

]

{ #category : #testing }
LcsApplicationEnvironment class >> hasInitializedApplicationEnvironment [
	^ self currentApplicationEnvironment notNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentSystem [
	^ self applicationEnvironmentDoesNotHave: [ :env | env currentSystem isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoCurrentUnitOfWork [
	^ self applicationEnvironmentDoesNotHave: [ :env | env currentUnitOfWork isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoninitializedApplicationEnvironment [
	^ self currentApplicationEnvironment isNil
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasSystemManager [
	^ self applicationEnvironmentHas: [ :env | env hasSystemManager ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasUnitsOfWorkManager [
	^ self applicationEnvironmentHas: [ :env | env hasUnitsOfWorkManager ]
]

{ #category : #initiailize }
LcsApplicationEnvironment class >> initializeApplicationEnvironment [
	self singleton notNil ifTrue: [ self error: 'Environment is already initialized' ].
	System abortTransaction.
	self singleton: self basicNew initialize.
	System commitTransaction.
	^ self currentApplicationEnvironment
]

{ #category : #running }
LcsApplicationEnvironment class >> isInActiveStatus [
	^ self applicationEnvironmentHas: [ :env | env isInActiveStatus]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> makeSystemCurrent: aSystem [
	self applicationEnvironmentDo: [ :env | env makeSystemCurrent: aSystem ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> new [
	"Use #initializeEnvironment instead"
	self shouldNotImplement
]

{ #category : #release }
LcsApplicationEnvironment class >> releaseApplicationEnvironment [
	self applicationEnvironmentDo: [ :env | 
		 env releaseApplicationEnvironment.
		 self singleton: nil ].
	
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> removeCurrentSystem [
	self applicationEnvironmentDo: [  :env  | env removeCurrentSystem ]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> removeCurrentUnitOfWork [
	self applicationEnvironmentDo: [ :env | env  removeCurrentUnitOfWork ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> resetApplicationEnvironment [
	self releaseApplicationEnvironment.
	self initializeApplicationEnvironment.
	^ self currentApplicationEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment class >> restoreToCurrent: aSystem [
	self applicationEnvironmentDo: [ :env | env restoreToCurrent: aSystem ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> restoreToCurrentApplicationEnvironment: anApplicationEnvironment [
	self singleton: anApplicationEnvironment.
	self applicationEnvironmentDo: [ :env | env restoreApplicationEnvironment ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton [
	^ singleton
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton: anApplicationEnvironment [
	singleton := anApplicationEnvironment
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> suspendApplicationEnvironment [
	self applicationEnvironmentDo: [ :env | env suspendApplicationEnvironment ]
]

{ #category : #'application environment - modify' }
LcsApplicationEnvironment class >> suspendCurrentApplicationEnvironment [
	| currentApplicationEnvironment |
	currentApplicationEnvironment := self currentApplicationEnvironment.
	self applicationEnvironmentDo: [ :env | env suspendApplicationEnvironment ].
	self singleton: nil.
	
	self assert: (currentApplicationEnvironment 
						ifNil: [ true ] 
						ifNotNil:  [ currentApplicationEnvironment isInSuspendedStatus ]).
	^currentApplicationEnvironment
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> suspendCurrentSystem [
	^ self applicationEnvironmentDo: [ :env | env suspendCurrentSystem ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> systemManager [
	^ self applicationEnvironmentObject: [ :env | env systemManager ]
]

{ #category : #'application environment' }
LcsApplicationEnvironment class >> unitsOfWorkManager [
	^ self applicationEnvironmentObject: [ :env | env unitsOfWorkManager ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> verifyApplicationEnvironment [
	self hasInitializedApplicationEnvironment
		ifFalse: [ LcsApplicationEnivronmentNotInitializedError
				signal: 'Unable to create a system because application environment is not initialized' ].
	^ true
]

{ #category : #accessing }
LcsApplicationEnvironment >> applicationEnvironment [
	^ self
]

{ #category : #'gt view' }
LcsApplicationEnvironment >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Status' item: self status.
		LcsApplicationEnvironmentViewItem newOn: self label: 'System Manager' item: self systemManager.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Units Of Work' item: self unitsOfWorkManager.}
]

{ #category : #system }
LcsApplicationEnvironment >> createCurrentSystemFor: aSystemClass [
	^ self systemManager createCurrentSystemFor: aSystemClass
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> createUnitOfWork [
	^ self unitsOfWorkManager createUnitOfWork
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem [
	^ self systemManager currentSystem
]

{ #category : #system }
LcsApplicationEnvironment >> currentSystem: aSystem [
	^ self systemManager currentSystem: aSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #'gt view' }
LcsApplicationEnvironment >> gtApplicationEnvironmentFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Application Environment';
		priority: 10;
		expandUpTo: 3;
		items: [ self applicationEnvironmentViewChildren ];
		children: [ :viewItem | viewItem children ];
		column: 'Option'
			text: [ :viewItem | viewItem label ]
			width: 200;
		column: 'Value' text: [ :viewItem | viewItem item displayString ] width: 300;
		column: '' stencil: [ :viewItem | viewItem actionButton] width: 70;
		column: '' stencil: [ :viewItem | viewItem action2Button] width: 70;
		send: #item;
		actionUpdateButton;
		yourself
]

{ #category : #'gt view' }
LcsApplicationEnvironment >> gtSystemManagerFor: aView [
	<gtView>
	^ aView forward
		title: 'System Manager';
		priority: 11;
		object: [ self systemManager ];
		view: #gtSystemManagerFor:
		yourself
]

{ #category : #'gt view' }
LcsApplicationEnvironment >> gtUnitsOfWorkManagerFor: aView [
	<gtView>
	^ aView forward
		title: 'Units Of Work';
		priority: 12;
		object: [ self unitsOfWorkManager ];
		view: #gtUnitsOfWorkManagerFor:
		yourself
]

{ #category : #testing }
LcsApplicationEnvironment >> hasCurrentUnitOfWork [
	^ self unitsOfWorkManager hasCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasNoCurrentUnitOfWork [
	^ self unitsOfWorkManager hasNoCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasSystemManager [
	^ self systemManager notNil
]

{ #category : #testing }
LcsApplicationEnvironment >> hasUnitsOfWorkManager [
	^self unitsOfWorkManager notNil
]

{ #category : #initialize }
LcsApplicationEnvironment >> initialize [
	super initialize.
	self systemManager: (LcsSystemManager newOn: self).
	self unitsOfWorkManager: (LcsUnitsOfWorkManager newOn: self).
	self status: (LcsApplicationEnvironmentActiveStatus newOn: self)
]

{ #category : #testing }
LcsApplicationEnvironment >> isInActiveStatus [
	^self status isInActiveStatus
]

{ #category : #testing }
LcsApplicationEnvironment >> isInSActiveStatus [
	^self status isInSActiveStatus
]

{ #category : #testing }
LcsApplicationEnvironment >> isInSuspendedStatus [
	^self status isInSuspendedStatus
]

{ #category : #system }
LcsApplicationEnvironment >> makeSystemCurrent: aSystem [
	self systemManager makeSystemCurrent: aSystem
]

{ #category : #release }
LcsApplicationEnvironment >> releaseApplicationEnvironment [
	self systemManager ifNotNil: [ :manager | manager releaseApplicationEnvironment ].
	self unitsOfWorkManager ifNotNil: [ :manager | manager releaseApplicationEnvironment ].
	LcsObject releaseApplicationEnvironment  
]

{ #category : #system }
LcsApplicationEnvironment >> removeCurrentSystem [
	^ self systemManager removeCurrentSystem
]

{ #category : #'unit of work' }
LcsApplicationEnvironment >> removeCurrentUnitOfWork [
	^ self unitsOfWorkManager removeCurrentUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> restoreApplicationEnvironment [
	self status restoreApplicationEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment >> restoreToCurrent: aSystem [
	self 
		removeCurrentSystem;
		makeSystemCurrent: aSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> status [
	^ status
]

{ #category : #accessing }
LcsApplicationEnvironment >> status: anObject [
	status := anObject
]

{ #category : #system }
LcsApplicationEnvironment >> suspendApplicationEnvironment [
	^ self status suspendApplicationEnvironment
]

{ #category : #system }
LcsApplicationEnvironment >> suspendCurrentSystem [
	^ self systemManager suspendCurrentSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager [
	^ systemManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager: anObject [
	systemManager := anObject
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager [
	^ unitsOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager: anObject [
	unitsOfWorkManager := anObject
]
