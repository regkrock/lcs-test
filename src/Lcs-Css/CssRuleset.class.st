Class {
	#name : #CssRuleset,
	#superclass : #CssObject,
	#instVars : [
		'selector',
		'nestedRulesets',
		'declarations'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance  creation' }
CssRuleset class >> on: aParent [
	^ self new
		initializeOn: aParent;
		yourself
]

{ #category : #printing }
CssRuleset >> compressedCssOn: aStream [
	self nestedRulesets isEmpty
		ifTrue: [ aStream
				nextPutAll: self selector;
				nextPutAll: '{'.
			self compressedDeclarationsOn: aStream ]
		ifFalse: [ self nestedRulesets
				do: [ :eachNestRulesets | 
					aStream
						nextPutAll: self selector;
						space;
						nextPutAll: eachNestRulesets selector;
						nextPutAll: '{'.
					eachNestRulesets compressedDeclarationsOn: aStream ]
				separatedBy: [aStream nextPutAll: '}'] ].
	aStream nextPutAll: '}'.
	^ aStream contents
]

{ #category : #printing }
CssRuleset >> compressedDeclarationsOn: aStream [
	self declarations do: [ :eachProperty | eachProperty compressedCssOn: aStream ]
]

{ #category : #accessing }
CssRuleset >> declarations [
	^ declarations
]

{ #category : #accessing }
CssRuleset >> declarations: anObject [
	declarations := anObject
]

{ #category : #initialize }
CssRuleset >> initialize [
	super initialize.
	self declarations: OrderedCollection new.
	self nestedRulesets: OrderedCollection new 
]

{ #category : #initialize }
CssRuleset >> initializeOn: aParent [ 
	self parent: aParent
]

{ #category : #accessing }
CssRuleset >> nestedRulesets [
	^ nestedRulesets
]

{ #category : #accessing }
CssRuleset >> nestedRulesets: aCollection [
	nestedRulesets := aCollection
]

{ #category : #children }
CssRuleset >> nestedSelector: aSelectorName with: aBlock [
	| ruleset |
	ruleset := self newRulesetNamed: aSelectorName.
	aBlock value: ruleset.
	self nestedRulesets add: ruleset
]

{ #category : #children }
CssRuleset >> newRulesetNamed: aSelectorName [
	^ (CssRuleset on: self)
		selector: aSelectorName;
		yourself
]

{ #category : #printing }
CssRuleset >> prettyCssOn: aStream [
	self nestedRulesets isEmpty
		ifTrue: [ 
			aStream nextPutAll: self selector.
			self prettyDeclarationsOn: aStream ]
		ifFalse: [ 
			self nestedRulesets
				do: [ :eachNestRulesets | 
					aStream
						nextPutAll: self selector;
						space;
						nextPutAll: eachNestRulesets selector.
					eachNestRulesets prettyDeclarationsOn: aStream ] 
				separatedBy: [aStream cr] ]
]

{ #category : #printing }
CssRuleset >> prettyDeclarationsOn: aStream [
	aStream
		nextPutAll: ' {';
		cr.
	self declarations
		do: [ :eachDeclaration | 
			aStream tab.
			eachDeclaration prettyCssOn: aStream ]
		separatedBy: [ aStream cr ].
	aStream
		cr;
		nextPutAll: '}'
]

{ #category : #accessing }
CssRuleset >> property: aString value: aValue [
	self declarations add: (
		(CssDeclaration on: self) 
			propertyName: aString;
			propertyValue: aValue;
			yourself)
			
]

{ #category : #accessing }
CssRuleset >> selector [
	^ selector
]

{ #category : #accessing }
CssRuleset >> selector: anObject [
	selector := anObject
]
