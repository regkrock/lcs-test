Class {
	#name : #CssDeclarationTest,
	#superclass : #TestCase,
	#category : #'Lcs-CssTests-Tests'
}

{ #category : #test }
CssDeclarationTest >> testDeclaration [
	| declaration |
	declaration := CssDeclaration new 
					propertyName: 'color';
					propertyValue: 'red';
					yourself.
	self assert: declaration propertyName = 'color'.
	self assert: declaration propertyValue = 'red'.
	self assert: declaration prettyCssString equals: 'color: red;'.
	self assert: declaration compressedCssString equals: 'color:red;'
]
