"
All application test classes should inherit from this class
"
Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #running }
LcsTestCase >> abortTransaction [
	System abortTransaction
]

{ #category : #running }
LcsTestCase >> beginTransaction [
	System beginTransaction
]

{ #category : #accessing }
LcsTestCase >> classNamed: aString [
	^ [ aString asClass ] on: NotFound do: [ nil ]
]

{ #category : #running }
LcsTestCase >> commitTransaction [
	System commitTransaction
]

{ #category : #refactoring }
LcsTestCase >> createClassName: aString superclassName: aSuperclassName category: aCategory [
	(self classNamed: aString)
		ifNil: [ 
			(RBAddClassRefactoring
				addClass: aString asSymbol
				superclass: aSuperclassName asClass
				subclasses: #()
				category: aCategory asSymbol) execute ]
]

{ #category : #accessing }
LcsTestCase >> domainObjectClass [
	"This is done for packaging loading purposes"
	^ LcsObject subclasses detect: [ :each | each name = #LcsDomainObject ] ifNone: [ nil ]
]

{ #category : #refactoring }
LcsTestCase >> removeClassName: aString [
	(self classNamed: aString)
		ifNotNil: [ (RBRemoveClassChange removeClassName: aString asSymbol) execute ]
]

{ #category : #refactoring }
LcsTestCase >> removeClassesNamed: aCollectionOfClassNaes [
	aCollectionOfClassNaes do: [ :eachClassName | self removeClassName: eachClassName ]
]
