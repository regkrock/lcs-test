"
This class and its subclasses define a slot:

slotName - this is the name of the slot and is the same as the instvarName. 
"
Class {
	#name : #LcsSlotDefintion,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'required',
		'validator',
		'initialValueBlock'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsSlotDefintion >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #validation }
LcsSlotDefintion >> addValidateConfigurationResultTo: aValidator [
	(self domainClass allInstVarNames includes: self slotName)
		ifFalse: [ aValidator
				add: (LcsValidatorIssueMessage newOn: self message: self slotDoesNotExistMessage) ]
]

{ #category : #configuration }
LcsSlotDefintion >> beOptional [
	self required: false
]

{ #category : #configuration }
LcsSlotDefintion >> beRequired [
	self required: true
]

{ #category : #configuration }
LcsSlotDefintion >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : #defaults }
LcsSlotDefintion >> createNewInstanceOf: aClass inContext: context [
	aClass isDomainClass
		ifTrue: [ aClass newInContext: context ]
		ifFalse: [ aClass new ]
]

{ #category : #'application environment' }
LcsSlotDefintion >> currentUnitOfWork [
	^ #LcsApplicationEnvironment asClass currentUnitOfWork
]

{ #category : #defaults }
LcsSlotDefintion >> defaultInitialValueBlock [
	^ [ self slotTypes any new ]
]

{ #category : #'slot model' }
LcsSlotDefintion >> domainClass [
	^ self parent domainClass
]

{ #category : #'gt view' }
LcsSlotDefintion >> domainClassName [
	self parent ifNil: [ ^ self parent class name].
	^self parent domainClass
]

{ #category : #'slot model' }
LcsSlotDefintion >> getValueIn: aDomainObject [

	^ (self currentUnitOfWork changedSlotRecordFor: aDomainObject slotNamed: self slotName)
		ifNil: [ aDomainObject instVarNamed: self slotName asString ]
		ifNotNil: [ :changedSlotRecord | changedSlotRecord newValue ]
]

{ #category : #'gt view' }
LcsSlotDefintion >> gtSlotDefinitionAttributes [
	^ OrderedCollection new
		add: 'domainClass' -> self domainClassName;
		add: 'slotName' -> self slotName;
		add: 'slotTypes' -> self slotTypeClassNames;
		add: 'required' -> self isRequired;
		yourself
]

{ #category : #'gt view' }
LcsSlotDefintion >> gtSlotDefinitionViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		priority: 10;
		items: [ self gtSlotDefinitionAttributes ];
		column: 'Option'
			text: #key
			width: 200;
		column: 'Value'
			text: [ :each | each value displayString ];
		send: #value;
		yourself
]

{ #category : #'gt view' }
LcsSlotDefintion >> gtViewSlotModelChildren [
	^ {
		LcsSlotModelViewItem newLabel: 'domainClass' item: self domainClass.
		LcsSlotModelViewItem newLabel: 'slotName' item: self slotName.
		LcsSlotModelViewItem newLabel: 'slotTypes' item: self slotTypeClassNames.
		LcsSlotModelViewItem newLabel: 'required' item: self isRequired.
		}
]

{ #category : #accessing }
LcsSlotDefintion >> initialValue [
	^ self initialValueBlock value
]

{ #category : #accessing }
LcsSlotDefintion >> initialValue: anObject [
	self initialValueBlock: [ anObject ]
]

{ #category : #accessing }
LcsSlotDefintion >> initialValueBlock [
	^ initialValueBlock
]

{ #category : #accessing }
LcsSlotDefintion >> initialValueBlock: aBlock [ 
	initialValueBlock := aBlock
]

{ #category : #accessing }
LcsSlotDefintion >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject.
	(newValue isDomainObject and: [ self currentSystem notNil ])
		ifNotNil: [ self currentUnitOfWork addObject: newValue context: aDomainObject ].
	^newValue
]

{ #category : #initialize }
LcsSlotDefintion >> initialize [
	super initialize.
	self initializeSlotTypes.
	self initialValueBlock: self defaultInitialValueBlock
]

{ #category : #initialize }
LcsSlotDefintion >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #accessing }
LcsSlotDefintion >> initializeSlotValueIn: aDomainObject [
	self setValueTo: (self initialValueFor: aDomainObject) in: aDomainObject
]

{ #category : #accessing }
LcsSlotDefintion >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #accessing }
LcsSlotDefintion >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ false
]

{ #category : #testing }
LcsSlotDefintion >> isGlobalCollectionSlot [
	^ false
]

{ #category : #validation }
LcsSlotDefintion >> isInstanceVariableDefined [
	^ self domainClass allInstVarNames includes: self slotName
]

{ #category : #testing }
LcsSlotDefintion >> isNotRequired [
	^ self isRequired not
]

{ #category : #testing }
LcsSlotDefintion >> isOptional [
	^ self required ~~ true
]

{ #category : #testing }
LcsSlotDefintion >> isRequired [
	^ self required == true
]

{ #category : #accessing }
LcsSlotDefintion >> parent [
	^ parent
]

{ #category : #accessing }
LcsSlotDefintion >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsSlotDefintion >> required [
	^ required
]

{ #category : #accessing }
LcsSlotDefintion >> required: anObject [
	required := anObject
]

{ #category : #'slot model' }
LcsSlotDefintion >> setValueTo: anObject in: aDomainObject [
	self currentUnitOfWork setValueTo: anObject in: aDomainObject forSlot: self
]

{ #category : #defaults }
LcsSlotDefintion >> slotClass [
	^ self slotTypes any
]

{ #category : #validation }
LcsSlotDefintion >> slotDoesNotExistMessage [
	^ 'Slot name ' , self slotName asString , ' does not exist in '
		, self domainClass name
]

{ #category : #accessing }
LcsSlotDefintion >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefintion >> slotName: anObject [
	slotName := anObject
]

{ #category : #'gt view' }
LcsSlotDefintion >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: eachClass name displayString] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : #accessing }
LcsSlotDefintion >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefintion >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #accessing }
LcsSlotDefintion >> validator [
	^ validator
]

{ #category : #accessing }
LcsSlotDefintion >> validator: anObject [
	validator := anObject
]
