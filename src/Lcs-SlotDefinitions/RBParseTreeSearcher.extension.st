Extension { #name : #RBParseTreeSearcher }

{ #category : #'*Lcs-SlotDefinitions' }
RBParseTreeSearcher class >> getterMethod: aVarName [ 
	^ self new
		matchesMethod: '`method ^' , aVarName do: [:aNode :ans | aNode selector];
		matchesMethod: '`method ^' , aVarName, ' ifNil:[ `@expr]' do: [:aNode :ans | aNode selector];
		yourself
]

{ #category : #'*Lcs-SlotDefinitions' }
RBParseTreeSearcher class >> returnSlotSetterMethod: aVarName [ 

	^(self new)
		matchesAnyMethodOf: (
			Array 
				with: '`method: `Arg ^ self setValueOfSlotNamed: ''' , aVarName , ''' to: `Arg')
			do: [:aNode :ans | aNode selector];
		yourself
]

{ #category : #'*Lcs-SlotDefinitions' }
RBParseTreeSearcher class >> setterMethod: aVarName [ 
	^(self new)
		matchesAnyMethodOf: (Array with: '`method: `Arg ' , aVarName , ' := `Arg'
					with: '`method: `Arg ^' , aVarName , ' := `Arg')
			do: [:aNode :ans | aNode selector];
		yourself
]

{ #category : #'*Lcs-SlotDefinitions' }
RBParseTreeSearcher class >> slotGetterMethod: aVarName [ 
	^ self new
		matchesMethod: '`method ^ self getValueOfSlotNamed: ''' , aVarName , '''' do: [:aNode :ans | aNode selector];
		yourself
]

{ #category : #'*Lcs-SlotDefinitions' }
RBParseTreeSearcher class >> slotSetterMethod: aVarName [ 
	^(self new)
		matchesAnyMethodOf: (
			Array 
				with: '`method: `Arg ' , 'self setValueOfSlotNamed: ''' , aVarName , ''' to: `Arg')
			do: [:aNode :ans | aNode selector];
		yourself
]
