Class {
	#name : #LxxPrototype2Module,
	#superclass : #LcsModule,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #modules }
LxxPrototype2Module class >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototype2Submodule;
		yourself
]

{ #category : #configuration }
LxxPrototype2Module class >> moduleName [
	^ 'Prototype 2 Module'
]
