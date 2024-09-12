Extension { #name : #LcsSystemManager }

{ #category : #'*Lcs-DomainBase' }
LcsSystemManager >> availableSystemClasses [
	^ LcsBaseSystem allSubclasses
		select: [ :eachClass | eachClass subclasses isEmpty ]
]
