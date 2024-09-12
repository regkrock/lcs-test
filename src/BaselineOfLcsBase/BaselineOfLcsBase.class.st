Class {
	#name : #BaselineOfLcsBase,
	#superclass : #BaselineOf,
	#category : #BaselineOfLcsBase
}

{ #category : #accessing }
BaselineOfLcsBase class >> manuallyLoadLepiter [
	| repository defaultDatabase currentProperties |
	
	repository := IceRepository registry 
				detect: [ :aRepository | aRepository name = 'lcs-base' ] 
				ifNone: [nil].

	defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
	currentProperties := defaultDatabase properties.
	currentProperties addRegisteredDirectory: repository repositoryDirectory / 'lepiter'.
	defaultDatabase reload.
]

{ #category : #baselines }
BaselineOfLcsBase >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Lcs-GemStoneMocks'.
			spec package: 'LcsBase'  with: [ spec requires: #('Lcs-GemStoneMocks' ) ].
			spec package: 'Lcs-PharoExtensions' with: [ spec requires: #('LcsBase' ) ].
			"spec package: 'Lcs-Base-Pharo'  with: [ spec requires: #('LcsBase' ) ]."
			spec package: 'Lcs-UnitOfWOrk' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-SlotDefinitions' with: [ spec requires: #('LcsBase' ) ].
			spec package: 'Lcs-SystemManagement' with: [ spec requires: #('LcsBase' 'Lcs-UnitOfWOrk' 'Lcs-SlotDefinitions') ].
			spec package: 'Lcs-DomainBase' with: [ spec requires: #('Lcs-SystemManagement') ].
			spec package: 'Lcs-Geography' with: [ spec requires: #('Lcs-DomainBase' ) ].
			spec package: 'Lcs-LegalEntities' with: [ spec requires: #('Lcs-DomainBase' 'Lcs-Geography') ].
			spec package: 'Lcs-System' with: [ spec requires: #('Lcs-LegalEntities' 'Lcs-Geography' ) ].
			spec package: 'Lcs-WarRabbitLibrary' with: [ spec requires: #('Lcs-DomainBase') ].

			" Systems for experimentation "
			spec package: 'Lcs-PrototypeSystem' with: [ spec requires: #('Lcs-DomainBase') ].  

			" Tests on main code "			
			spec package: 'Lcs-BaseTests' with: [ spec requires: #('LcsBase')  ].
			spec package: 'Lcs-SystemManagementTests' with: [ spec requires: #('Lcs-SystemManagement' 'Lcs-BaseTests') ].
			spec package: 'Lcs-Tests' with: [ spec requires: #('Lcs-DomainBase' 'Lcs-BaseTests' 'Lcs-Tools') ].  
			spec package: 'Lcs-SystemTests' with: [ spec requires: #('Lcs-System' 'Lcs-Tests') ].  
			spec package: 'Lcs-WarRabbitLibraryTests' with: [ spec requires: #('Lcs-WarRabbitLibrary' 'Lcs-Tests') ].  

			" Tests on experimentation systems "			
			spec package: 'Lcs-PrototypeSystemTests' with: [ spec requires: #('Lcs-PrototypeSystem' 'Lcs-SystemManagementTests' 'Lcs-Tests' 'Lcs-SlotDefinitions' 'Lcs-Tools') ].  

			" Tools "
			spec package: 'Lcs-Tools' with: [ spec requires: #('LcsBase' 'Lcs-SlotDefinitions') ].
			
			" Examples "
			spec package: 'Lcs-Examples' with: [ spec requires: #('LcsBase') ].
			
			"Css"
			spec package: 'Lcs-Css' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-CssTests' with: [ spec requires: #('Lcs-Tests' 'Lcs-Css') ].
				]
]
