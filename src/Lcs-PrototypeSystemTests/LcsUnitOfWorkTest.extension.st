Extension { #name : #LcsUnitOfWorkTest }

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsUnitOfWorkTest >> testDeleteDomainObject [
	"| domainObject |
	LxxPrototypeSystem new. 
	domainObject := LcsDomainObject new.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork changedObjects isEmpty.
	LcsApplicationEnvironment currentUnitOfWork applyChanges.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects notEmpty.
	
	domainObject delete.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects size = 1.
	self assert: LcsApplicationEnvironment currentUnitOfWork changedObjects isEmpty.
	self assert: (LcsApplicationEnvironment currentUnitOfWork deletedObjects any isKindOf: LcsDeletedObjectRecord).
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects any domainObject == domainObject"
]
