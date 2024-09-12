Class {
	#name : #CssVariable,
	#superclass : #CssObject,
	#instVars : [
		'cssPropertyValue',
		'declarations'
	],
	#category : #'Lcs-Css'
}

{ #category : #accessing }
CssVariable >> declarations [
	^ declarations
]

{ #category : #accessing }
CssVariable >> declarations: anObject [ 
	declarations := anObject
]

{ #category : #accessing }
CssVariable >> initialize [
	self declarations: OrderedCollection new
]
