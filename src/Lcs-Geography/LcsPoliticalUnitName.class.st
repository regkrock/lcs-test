Class {
	#name : #LcsPoliticalUnitName,
	#superclass : #LcsDomainObject,
	#instVars : [
		'fullName',
		'shortName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsPoliticalUnitName >> fullNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'fullName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #accessing }
LcsPoliticalUnitName >> shortNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'shortName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]
