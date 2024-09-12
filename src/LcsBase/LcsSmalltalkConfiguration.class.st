Class {
	#name : #LcsSmalltalkConfiguration,
	#superclass : #LcsObject,
	#category : #LcsBase
}

{ #category : #accessing }
LcsSmalltalkConfiguration class >> booleanClass [
	^ Boolean
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> dateClass [
	^ Date
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> identityDictionaryClass [
	^ Dictionary
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> identitySetClass [
	^ IdentitySet
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> integerClass [
	^ Integer
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> objectKeyDictionaryClass [
	^ Dictionary
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> scaledDeciamlClass [
	^ ScaledDecimal
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> setClass [

	^ IdentitySet
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> stringClass [
	^ String
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> stringDictionaryClass [
	^ Dictionary
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> symbolDictionaryClass [

	^ Dictionary
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> systemDictionary [
	^ SmalltalkImage current globals
]

{ #category : #accessing }
LcsSmalltalkConfiguration class >> timeClass [
	^ Time
]

{ #category : #asking }
LcsSmalltalkConfiguration >> classSelecotrFor: aClass [
]
