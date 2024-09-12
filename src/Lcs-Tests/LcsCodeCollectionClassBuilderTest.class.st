Class {
	#name : #LcsCodeCollectionClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testCreationStringForCreatingLxxGendersSubclassOfLcsCodes [
	| builder |
	builder := LcsCodeCollectionClassBuilder  new.
	builder 
		newClassName: 'LxxGenders';
		targetPackageName: 'Lcs-BarebonesSystem';
		rootName: 'Genders'.
	self assert: builder classCreationString equals: 'LcsCodes subclass: #LxxGenders
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
]
