Class {
	#name : #LcsUnitOfWorkViewItem,
	#superclass : #LcsViewItem,
	#category : #LcsBase
}

{ #category : #default }
LcsUnitOfWorkViewItem class >> defaultChildrenSelector [
	^ #gtUnitOfWorkChildren
]

{ #category : #accessing }
LcsUnitOfWorkViewItem >> children [
	self item isCollection ifFalse: [ ^ #()].
	self item isEmpty ifTrue: [ ^ {} ].
	^ (self item select: [ :each | each respondsTo: self childrenSelector ])
		collect: [ :each | each  perform: self childrenSelector ]

]

{ #category : #accessing }
LcsUnitOfWorkViewItem >> gtItemDisplayString [
	^ (self item respondsTo: #gtItemDisplayString)
		ifTrue: [ self item gtItemDisplayString ]
		ifFalse: [ self item displayString ]
]

{ #category : #accessing }
LcsUnitOfWorkViewItem >> gtViewDisplayString [
	^ (self item canUnderstand: #gtViewDisplayString)
		ifTrue: [ self item gtViewDisplayString ]
		ifFalse: [ self item displayString ]
]
