Class {
	#name : #LcsDomainClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsDomainClassBuilder class >> targetSuperclassName [
	^ 'LcsDomainObject'
]

{ #category : #accessing }
LcsDomainClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #accessing }
LcsDomainClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]
