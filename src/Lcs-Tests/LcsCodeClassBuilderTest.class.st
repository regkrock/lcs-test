Class {
	#name : #LcsCodeClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeClassBuilderTest >> testCreationStringForCreatingLxxMaleSubclassOfLxxGender [
	| builder |
	builder := LcsCodeClassBuilder  new.
	builder 
		newClassName: 'LxxMale';
		targetPackageName: 'Lcs-BarebonesSystem';
		targetSuperclassName: 'LxxGender';
		rootName: 'Male'.
	self assert: builder classCreationString equals: 'LxxGender subclass: #LxxMale
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
]
