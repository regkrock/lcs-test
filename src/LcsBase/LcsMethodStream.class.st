Class {
	#name : #LcsMethodStream,
	#superclass : #LcsObject,
	#instVars : [
		'stream',
		'indentLevel'
	],
	#category : #LcsBase
}

{ #category : #accessing }
LcsMethodStream >> addCommand: aString [
	self newLine nextPutAll: aString; nextPutAll: ';'
]

{ #category : #building }
LcsMethodStream >> addSetter: aString contents: aContentString [
	self newLine
		nextPutAll: aString;
		nextPutAll: ': ';
		nextPutAll: aContentString;
		nextPutAll: ';'
]

{ #category : #accessing }
LcsMethodStream >> addSlotDefinitionClassCreatonLine: aSlotDefinitionClass [
	self newLine
		nextPutAll: '^ ';
		nextPutAll: aSlotDefinitionClass name;
		nextPutAll: ' new'.
	self increaseIndentLevel
]

{ #category : #building }
LcsMethodStream >> addYourself [
	self newLine
		nextPutAll: 'yourself'

]

{ #category : #stream }
LcsMethodStream >> contents [
	^ self stream contents
]

{ #category : #accessing }
LcsMethodStream >> increaseIndentLevel [
	self indentLevel: self indentLevel + 1
]

{ #category : #accessing }
LcsMethodStream >> indentLevel [
	^ indentLevel
]

{ #category : #accessing }
LcsMethodStream >> indentLevel: anObject [ 
	indentLevel := anObject
]

{ #category : #initiailize }
LcsMethodStream >> initialize [
	super initialize.
	self stream: (WriteStream on: String new).
	self indentLevel: 0
]

{ #category : #testing }
LcsMethodStream >> isLastCharacterLineTerminationCharacter [
	^ {Character lf.
		Character cr} includes: self stream contents last
]

{ #category : #building }
LcsMethodStream >> newLine [
	self stream contents isEmpty
		ifFalse: [ self isLastCharacterLineTerminationCharacter ifFalse: [ self stream cr ] ].
	self indentLevel timesRepeat: [ stream tab ].
	^ self stream
]

{ #category : #building }
LcsMethodStream >> startSlotDefintionSource: aString [
	self newLine nextPutAll: aString , 'SlotDefinition'.
	self increaseIndentLevel.
	self newLine nextPutAll: '<slotDefinition>'.
]

{ #category : #accessing }
LcsMethodStream >> stream [
	^ stream
]

{ #category : #accessing }
LcsMethodStream >> stream: anObject [
	stream := anObject
]
