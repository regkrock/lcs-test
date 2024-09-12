"
This is where the configuration information for the module is stored.
"
Class {
	#name : #LcsGeographyModuleConfiguration,
	#superclass : #LcsBaseConfiguration,
	#instVars : [
		'defaultPostalCodeName',
		'defaultPoliticalUnitName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPoliticalUnitNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'defaultPoliticalUnitName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPostalCodeNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'defaultPostalCodeName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]
