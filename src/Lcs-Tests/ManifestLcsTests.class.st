"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLcsTests,
	#superclass : #PackageManifest,
	#category : #'Lcs-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestLcsTests class >> ruleAssertEqualSignIntoAssertEqualsV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#LcsDomainObjectTest)) #'2024-03-11T13:32:20.496515-04:00') )
]

{ #category : #'code-critics' }
ManifestLcsTests class >> ruleReShouldSendSuperTearDownAsLastMessageV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#LcsDomainTest #tearDown #false)) #'2024-03-11T12:43:41.167671-04:00') )
]
