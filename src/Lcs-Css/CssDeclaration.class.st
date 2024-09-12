Class {
	#name : #CssDeclaration,
	#superclass : #CssObject,
	#instVars : [
		'propertyName',
		'propertyValue'
	],
	#category : #'Lcs-Css'
}

{ #category : #'istance creation' }
CssDeclaration class >> on: aRuleSet [
	^ self new
		initializeOn: aRuleSet;
		yourself
]

{ #category : #printing }
CssDeclaration >> compressedCssOn: aStream [
	aStream nextPutAll: self compressedDeclaration
]

{ #category : #printing }
CssDeclaration >> compressedDeclaration [
	^ self propertyName , ':' , self propertyValue , ';'
]

{ #category : #printing }
CssDeclaration >> declaration [
	^ self propertyName , ': ' , self propertyValue , ';'
]

{ #category : #initialize }
CssDeclaration >> initializeOn: aRuleSet [ 
	self parent: aRuleSet
]

{ #category : #printing }
CssDeclaration >> prettyCssOn: aStream [
	aStream nextPutAll: self declaration
]

{ #category : #accessing }
CssDeclaration >> propertyName [
	^ propertyName
]

{ #category : #accessing }
CssDeclaration >> propertyName: aString [
	propertyName := aString
]

{ #category : #accessing }
CssDeclaration >> propertyValue [
	^ propertyValue
]

{ #category : #accessing }
CssDeclaration >> propertyValue: aString [
	propertyValue := aString
]
