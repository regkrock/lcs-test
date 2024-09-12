Class {
	#name : #LcsDomainCollectionClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsDomainCollectionClassBuilder class >> targetSuperclassName [
	^ 'LcsDomainCollection'
]

{ #category : #accessing }
LcsDomainCollectionClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #accessing }
LcsDomainCollectionClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]
