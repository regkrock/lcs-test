Class {
	#name : #LcsCodeCollectionClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsCodes'
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> jobStepDescription [
	self printString
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> updateSlotModel [
	super updateSlotModel
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: 'LcsCodes'
]
