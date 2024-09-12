Class {
	#name : #LcsSystemConfigurationValidator,
	#superclass : #LcsValidator,
	#category : #'Lcs-DomainBase'
}

{ #category : #validation }
LcsSystemConfigurationValidator >> validateCurrentObject [
	self objectBeingValidated addValidateConfigurationResultTo: self
]
