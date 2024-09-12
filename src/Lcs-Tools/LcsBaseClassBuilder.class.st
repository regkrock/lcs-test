Class {
	#name : #LcsBaseClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'newClassName',
		'targetPackageName',
		'targetSuperclassName',
		'jobSteps'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsBaseClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #accessing }
LcsBaseClassBuilder class >> targetSuperclassName [
	^ nil
]

{ #category : #refactoring }
LcsBaseClassBuilder >> addCompletedRefactoring: aRefactoring [ 
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #template }
LcsBaseClassBuilder >> classCreationString [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self targetSuperclassName
			with: self newClassName
			with: self targetPackageName
]

{ #category : #refactoring }
LcsBaseClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #accessing }
LcsBaseClassBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self classCreationString asRopedText ]
	
]

{ #category : #initialize }
LcsBaseClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #initialize }
LcsBaseClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseClassBuilder >> installCode [
	self addCompletedRefactoring: (RBAddClassChange definition: self classCreationString) execute.
	self installedClass: self completedRefactorings last changeClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #printing }
LcsBaseClassBuilder >> jobStepDescription [
	^ (WriteStream on: String new)
		nextPutAll: self stepNumber;
		nextPutAll: ') Install ';
		nextPutAll: self newClassName;
		contents
]

{ #category : #accessing }
LcsBaseClassBuilder >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsBaseClassBuilder >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #printing }
LcsBaseClassBuilder >> stepNumber [
	^ (self parent indexOf: self) printString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName: aString [
	targetPackageName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName [
	^ targetSuperclassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName: aString [
	targetSuperclassName := aString
]

{ #category : #install }
LcsBaseClassBuilder >> updateSlotModel [
	self installedClass initializeSlotModel
]

{ #category : #install }
LcsBaseClassBuilder >> verifyCodeInstallation [
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self assert: self installedClass slotModel isNil description: 'The class has been created but not yet installed in a system'
]

{ #category : #install }
LcsBaseClassBuilder >> verifySlotModelUpdates [
	self assert: self installedClass slotModel  notNil.
	self assert: (self currentSystem systemSlotModel hasSlotModelFor: self installedClass)
]
