Class {
	#name : #LcsCodeBuilderStepElement,
	#superclass : #BlElement,
	#instVars : [
		'labelElement',
		'targetElement',
		'statusElement'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance creation' }
LcsCodeBuilderStepElement class >> newFromStep: aCodeBuilderStepElement [
	^ self new 
		initializeFromStep: aCodeBuilderStepElement; 
		yourself
]

{ #category : #initialization }
LcsCodeBuilderStepElement >> initialize [
	| contents |
	super initialize.
	self 
		layout: BlLinearLayout horizontal;
		aptitude: BrShadowAptitude;
		zIndex: 10;
		background: Color white;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	contents := BlElement new
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent.
			c padding: (BlInsets all: 5) ].
	self initializeStatusElement.
	self initializeLabelElement.
	self initializeTargetElement.
	self addChild: statusElement as: #status.
	self addChild: contents.
	contents addChild: labelElement as: #label.
	contents addChild: targetElement as: #target.
]

{ #category : #initialization }
LcsCodeBuilderStepElement >> initializeFromStep: aCodeBuilderStepElement [
	| aStepText aTargetStep |
	statusElement background: aCodeBuilderStepElement stateColor.
	statusElement removeChildren.
	aCodeBuilderStepElement stepIcon
		ifNotNil: [ :anIcon | statusElement addChild: (anIcon asElement background: Color white) ].
	aStepText := aCodeBuilderStepElement gtDisplayText foreground: Color black.
	labelElement text: aStepText.
	aTargetStep := aCodeBuilderStepElement realTarget gtDisplayText
			foreground: Color gray;
			fontSize: 10.
	targetElement text: aTargetStep
]

{ #category : #initialization }
LcsCodeBuilderStepElement >> initializeLabelElement [
	labelElement := BrLabel new 
		zIndex: 10;
		aptitude: BrGlamorousLabelAptitude;
		addEventHandlerOn: BlClickEvent do: [ :anEvent | BlEvent fireEvent: anEvent target: self ];
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent. ];
		text: 'Step' asRopedText
]

{ #category : #accessing }
LcsCodeBuilderStepElement >> initializeStatusElement [
	statusElement := BrVerticalPane new vMatchParent; hExact: 15; background: Color white
]

{ #category : #initialization }
LcsCodeBuilderStepElement >> initializeTargetElement [
	targetElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new fontSize: 10; foreground: Color gray); 
		addEventHandlerOn: BlClickEvent do: [ :anEvent | BlEvent fireEvent: anEvent target: self ];
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent. ];
		text:  'Target'
]
