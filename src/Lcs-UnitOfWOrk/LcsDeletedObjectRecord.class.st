Class {
	#name : #LcsDeletedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #api }
LcsDeletedObjectRecord >> applyChanges [

	self error: 'Needs to be implemented'
]

{ #category : #accessing }
LcsDeletedObjectRecord >> viewItemLabel [
	^ 'Deleted'
]
