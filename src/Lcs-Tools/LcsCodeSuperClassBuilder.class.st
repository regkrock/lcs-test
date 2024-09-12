Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> jobStepDescription [
	self printString
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]
