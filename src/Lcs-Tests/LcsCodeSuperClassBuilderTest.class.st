Class {
	#name : #LcsCodeSuperClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeSuperClassBuilderTest >> testCreationStringForCreatingLxxGenderSubclassOfLcsCodesClass [
	| builder |
	builder := LcsCodeSuperClassBuilder new.
	builder 
		newClassName: 'LxxGender';
		targetPackageName: 'Lcs-BarebonesSystem';
		rootName: 'Gender'.
	self assert: builder classCreationString equals: 'LcsCode subclass: #LxxGender
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
	
]
