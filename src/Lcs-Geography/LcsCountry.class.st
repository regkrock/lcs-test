Class {
	#name : #LcsCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'countryName',
		'politicalUnitName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsCountry class >> countryNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'countryName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode';
		beRequired;
		validator: [ :string | string size = 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsGeographyModule moduleName;
		collectionSlotName: 'countries';
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> politicalUnitNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'politicalUnitName';
		beRequired;
		validator: [ :string | string size = 2 ];
		yourself
]

{ #category : #accessing }
LcsCountry >> countryName [
	^ self getValueOfSlotNamed: 'countryName'
]

{ #category : #accessing }
LcsCountry >> countryName: anObject [
	self setValueOfSlotNamed: 'countryName' to: anObject
]

{ #category : #accessing }
LcsCountry >> isoCode [
	^ self getValueOfSlotNamed: 'isoCode'
]

{ #category : #accessing }
LcsCountry >> isoCode: anObject [
	self setValueOfSlotNamed: 'isoCode' to: anObject
]

{ #category : #accessing }
LcsCountry >> politicalUnitName [
	^ self getValueOfSlotNamed: 'politicalUnitName'
]

{ #category : #accessing }
LcsCountry >> politicalUnitName: anObject [
	self setValueOfSlotNamed: 'politicalUnitName' to: anObject
]
