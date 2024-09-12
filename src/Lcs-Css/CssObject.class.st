Class {
	#name : #CssObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-Css'
}

{ #category : #printing }
CssObject >> compressedCssString [
	| stream |
	stream := WriteStream on: String new.
	self compressedCssOn: stream.
	^stream contents
]

{ #category : #accessing }
CssObject >> parent [
	^ parent
]

{ #category : #accessing }
CssObject >> parent: aCssObject [
	parent := aCssObject
]

{ #category : #printing }
CssObject >> prettyCssString [
	| stream |
	stream := WriteStream on: String new.
	self prettyCssOn: stream.
	^stream contents
]
