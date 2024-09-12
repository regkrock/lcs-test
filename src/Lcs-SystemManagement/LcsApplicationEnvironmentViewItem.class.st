Class {
	#name : #LcsApplicationEnvironmentViewItem,
	#superclass : #LcsViewItem,
	#instVars : [
		'context'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #default }
LcsApplicationEnvironmentViewItem class >> defaultChildrenSelector [
	^ #applicationEnvironmentViewChildren
]

{ #category : #'instance creation' }
LcsApplicationEnvironmentViewItem class >> newOn: anObject label: aLabel item: anItem [ 
	^ self new
		initializeOn: anObject label: aLabel item: anItem;
		yourself
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> action2Button [
	self isInstantiatedSystem ifTrue: [ ^ self stopSystemButton ].
	^ BrButton new
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> actionButton [
	self label = 'Initialized' ifTrue: [ ^ self startStopApplicationEnvironmentButton ].
	self isSystemClass ifTrue: [ ^ self startSystemButton ].
	self isInstantiatedSystem ifTrue: [ ^ self activateSuspendSystemButton ].

	^ BrButton new
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> activateSuspendSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: self item toggleActionButtonLabel;
		action: [ :aButton | self item toggleStatus ]
]

{ #category : #accessing }
LcsApplicationEnvironmentViewItem >> context [
	^ context
]

{ #category : #accessing }
LcsApplicationEnvironmentViewItem >> context: anObject [ 
	context := anObject
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> initializeOn: anObject label: aLabel item: anItem [ 
	self
		context: anObject;
		label: aLabel;
		item: anItem
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> isInstantiatedSystem [
	(self item respondsTo: #isApplicationSystem) ifFalse: [ ^ false ].
	^self item isApplicationSystem
]

{ #category : #testing }
LcsApplicationEnvironmentViewItem >> isSystemClass [
	self item isClass ifFalse: [ ^ false ].
	^self item isApplicationSystemClass
]

{ #category : #accessing }
LcsApplicationEnvironmentViewItem >> itemChildren: anItemChildrenSelector [
	self label = 'Available Systems'
		ifTrue: [ 
			^ self context applicationEnvironmentViewaAvailableSystemsChildren ].
	^ super itemChildren: anItemChildrenSelector
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> startNewSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Start';
		action: [ :aButton | self item new ]
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> startStopApplicationEnvironmentButton [
	^ self item == true
		ifTrue: [ BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Stop';
				action: [ :aButton | LcsApplicationEnvironment releaseApplicationEnvironment ] ]
		ifFalse: [ BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Start';
				action: [ :aButton | LcsApplicationEnvironment initializeApplicationEnvironment ] ]
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> startSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Start';
		action: [ :aButton | self item new ]
]

{ #category : #'gt view' }
LcsApplicationEnvironmentViewItem >> stopSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Stop';
		action: [ :aButton | self item removeSystem ]
]
