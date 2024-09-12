Class {
	#name : #LcsIndentedWriteStream,
	#superclass : #Object,
	#instVars : [
		'numberOfTabs',
		'stream'
	],
	#category : #LcsBase
}

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> contents [
	^self stream contents
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> cr [
	self stream cr
]

{ #category : #'stream extras' }
LcsIndentedWriteStream >> decrementNumberOfTabs [
	self numberOfTabs > 0 ifTrue: [
		numberOfTabs := numberOfTabs - 1 ]
]

{ #category : #'stream extras' }
LcsIndentedWriteStream >> incrementNumberOfTabs [
	numberOfTabs := numberOfTabs + 1
]

{ #category : #initialize }
LcsIndentedWriteStream >> initialize [
	self numberOfTabs: 0.
	self stream: (WriteStream on: String new)
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> newFileDirectoryLine: aString [
	self 
		newLine;
		startLine: '+' , aString
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> newLine [
	self cr
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> newLine: aString [
	self 
		newLine;
		startLine: aString
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> nextPut: aCharacter [
	self stream nextPut: aCharacter
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> nextPutAll: aString [
	self stream nextPutAll: aString
]

{ #category : #accessing }
LcsIndentedWriteStream >> numberOfTabs [
	^ numberOfTabs
]

{ #category : #accessing }
LcsIndentedWriteStream >> numberOfTabs: anObject [
	numberOfTabs := anObject
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> startLine [
	self numberOfTabs timesRepeat: [self stream tab]
]

{ #category : #'stream protocol' }
LcsIndentedWriteStream >> startLine: aString [
	self 
		startLine;
		nextPutAll: aString
]

{ #category : #accessing }
LcsIndentedWriteStream >> stream [
	^ stream
]

{ #category : #accessing }
LcsIndentedWriteStream >> stream: anObject [
	stream := anObject
]
