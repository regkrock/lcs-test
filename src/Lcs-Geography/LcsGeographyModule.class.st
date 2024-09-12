Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries'
	],
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGeographyModule class >> configurationSlotDefinition [
"	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsGeographyModuleConfiguration"
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> countriesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'countries';
		addSlotType: LcsCountries;
		addCollectionMemberType: LcsCountry;
		yourself
]

{ #category : #configuration }
LcsGeographyModule class >> moduleName [
	^ 'Geography Module'
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ countries
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	countries := anObject
]
