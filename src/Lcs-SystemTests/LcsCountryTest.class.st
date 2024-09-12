Class {
	#name : #LcsCountryTest,
	#superclass : #LcsSystemTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #tests }
LcsCountryTest >> testCreation [
	| country countries |
	self assert: LcsCountry slotModel hasSlotDefinitions.
	country := LcsCountry new.
	country 
		countryName: 'Canada';
		isoCode: 'CA'.
		
	self assert: country countryName equals: 'Canada'.
	self assert: country isoCode equals: 'CA'.

	self currentSystem currentUnitOfWork applyChanges.
	
	countries := self currentSystem geographyModule countries.
	self assert: countries size equals: 1.
	self assert: (countries includes: country)
	
]
