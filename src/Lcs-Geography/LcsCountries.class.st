Class {
	#name : #LcsCountries,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography'
}

{ #category : #'gt view' }
LcsCountries >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items' translated;
		priority: 0.5;
		items: [ self collection ];
		column: 'Country Name'
			text: [ :item | item countryName ]
			width: 200;
		column: 'Iso Code'
			text: [ :item | item isoCode ]
			width: 40;
		column: 'Political Unit Name'
			text: [ :item | item politicalUnitName ]
			width: 100
		"send: [ :item | (self overviewSend at: item key) onErrorDo: [ '?' ] ];"
		"actionUpdateButton;
		updateWhen: WebLinkStatusUpdated in: self announcer"
]
