Class {
	#name : #LcsUsersModule,
	#superclass : #LcsModule,
	#instVars : [
		'users'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #configuration }
LcsUsersModule class >> moduleName [
	^ 'Users Module'
]

{ #category : #'slot definitions' }
LcsUsersModule class >> usersSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'users';
		addSlotType: LcsUsers;
		addCollectionMemberType: LcsUser;
		yourself
]

{ #category : #accessing }
LcsUsersModule >> users [
	^ self getValueOfSlotNamed: 'users'
]

{ #category : #accessing }
LcsUsersModule >> users: anObject [
	self setValueOfSlotNamed: 'users' to: anObject
]
