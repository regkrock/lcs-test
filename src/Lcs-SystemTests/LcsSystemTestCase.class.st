Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-SystemTests'
}

{ #category : #running }
LcsSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
