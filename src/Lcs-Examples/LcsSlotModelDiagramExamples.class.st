Class {
	#name : #LcsSlotModelDiagramExamples,
	#superclass : #LcsObject,
	#category : #'Lcs-Examples'
}

{ #category : #example }
LcsSlotModelDiagramExamples >> domainObjectSlotModel [
	<gtExample>
	| model classes associations positions |

	classes := self domainObjectSlotModelClasses.
	associations := self domainObjectSlotModelAssociationsWithLabels.
	positions := self domainObjectSlotModelExplicitPositions.

	model := UmlClassDiagram new
		classHierarchyFor: classes
		withAssociationsAndLabels: associations.
		
	model layout custom: BlBasicLayout new.

	model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	
	^ model


]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelAssociationsWithLabels [
	^ {LcsSlotModel
			-> {{'slotDefintions'.
						LcsSlotDefintion}}.
		LcsSlotDefintion
			-> {{'parent'.
						LcsSlotModel}.
					{'domainClass'.
						LcsDomainObject}}.
		LcsDomainObject
			-> {{'slotModel'.
						LcsSlotModel}}.
		LcsSlotModel
			-> {{'domainClass'.
						LcsDomainObject}}}
]

{ #category : #pirvate }
LcsSlotModelDiagramExamples >> domainObjectSlotModelClasses [
	| classes |
	classes := OrderedCollection new
			addAll: LcsDomainObject withAllSuperclasses;
			addAll: LcsSlotModel withAllSuperclasses;
			addAll: LcsSlotDefintion withAllSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ].
	^ classes
]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^ (Array new: 27)
		at: 1 put: -333.0 @ -196.0;
		at: 2 put: -50.0 @ -326.0;
		at: 3 put: -61.0 @ -233.0;
		at: 4 put: 218.0 @ -189.0;
		at: 5 put: -244.9799994419123 @ -296.40216064453125;
		at: 6 put: -14.972185815148741 @ -296.40216064453125;
		at: 7 put: 16.443815866752907 @ -296.40216064453125;
		at: 8 put: 30.900001525878906 @ -234.27255409229602;
		at: 9 put: 30.900001525878906 @ -234.27255409229602;
		at: 10 put: 30.900001525878906 @ -234.27255409229602;
		at: 11 put: 30.900001525878906 @ -234.27255409229602;
		at: 12 put: 30.900001525878906 @ -211.1690747127179;
		at: 13 put: 30.900001525878906 @ -211.1690747127179;
		at: 14 put: 30.900001525878906 @ -211.1690747127179;
		at: 15 put: 30.900001525878906 @ -211.1690747127179;
		at: 16 put: -216.16000366210938 @ -180.45353535670387;
		at: 17 put: -216.16000366210938 @ -180.45353535670387;
		at: 18 put: -216.16000366210938 @ -180.45353535670387;
		at: 19 put: -216.16000366210938 @ -180.45353535670387;
		at: 20 put: -216.16000366210938 @ -231.62197617165015;
		at: 21 put: -216.16000366210938 @ -231.62197617165015;
		at: 22 put: -216.16000366210938 @ -231.62197617165015;
		at: 23 put: -216.16000366210938 @ -231.62197617165015;
		at: 24 put: -216.16000366210938 @ -211.65019984125837;
		at: 25 put: -216.16000366210938 @ -211.65019984125837;
		at: 26 put: -216.16000366210938 @ -211.65019984125837;
		at: 27 put: -216.16000366210938 @ -211.65019984125837;
		yourself
]

{ #category : #example }
LcsSlotModelDiagramExamples >> slotDefinitionsHierarchy [
	<gtExample>
	^ UmlClassDiagram new classHierarchyFor: LcsSlotDefintion withAllSubclasses
]

{ #category : #example }
LcsSlotModelDiagramExamples >> systemSlotModel [
	<gtExample>
	| model classes associations positions |

	classes := self systemSlotModelClasses.
	associations := self systemSlotModelAssociationsWithLabels.
	positions := self systemSlotModelExplicitPositions.

	model := UmlClassDiagram new
		classHierarchyFor: classes
		withAssociationsAndLabels: associations.
		
	model layout custom: BlBasicLayout new.

	model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	
	^ model


]

{ #category : #private }
LcsSlotModelDiagramExamples >> systemSlotModelAssociationsWithLabels [
	^ {LcsBaseSystem
			-> {{'systemSlotModel'.
						LcsSystemSlotModel}}.
		LcsSystemSlotModel
			-> {{'parent'.
						LcsBaseSystem}}.
		LcsDomainObject
			-> {{'slotModel'.
						LcsSlotModel}}.
		LcsSystemSlotModel
			-> {{'slotModels'.
						LcsSlotModel}}}
]

{ #category : #pirvate }
LcsSlotModelDiagramExamples >> systemSlotModelClasses [
	| classes |
	classes := OrderedCollection new
			add: LcsBaseSystem;
			addAll: LcsBaseSystem allSuperclasses;
			add: LcsSystemSlotModel;
			add: LcsSlotModel;
			addAll: LcsSlotModel allSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ].
	^ classes
]

{ #category : #private }
LcsSlotModelDiagramExamples >> systemSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^ (Array new: 35)
		at: 1 put: 31.0 @ 27.0;
		at: 2 put: 32.0 @ -55.0;
		at: 3 put: 26.0 @ -164.0;
		at: 4 put: 173.0 @ -266.0;
		at: 5 put: 276.0 @ 27.0;
		at: 6 put: 289.0 @ -163.0;
		at: 7 put: 82.63969459047217 @ -25.40216064453125;
		at: 8 put: 84.00257685302581 @ -134.40216064453125;
		at: 9 put: 102.41359850636331 @ -236.4021606445312;
		at: 10 put: 215.2622607565853 @ -236.4021606445312;
		at: 11 put: 226.61595209674837 @ -236.4021606445312;
		at: 12 put: 133.7080078125 @ 13.340521240234374;
		at: 13 put: 133.7080078125 @ 13.340521240234374;
		at: 14 put: 133.7080078125 @ 13.340521240234374;
		at: 15 put: 133.7080078125 @ 13.340521240234374;
		at: 16 put: 133.7080078125 @ 13.340521240234374;
		at: 17 put: 133.7080078125 @ 13.340521240234374;
		at: 18 put: 133.7080078125 @ 41.798919677734375;
		at: 19 put: 133.7080078125 @ 41.798919677734375;
		at: 20 put: 133.7080078125 @ 41.798919677734375;
		at: 21 put: 133.7080078125 @ 41.798919677734375;
		at: 22 put: 133.7080078125 @ 41.798919677734375;
		at: 23 put: 133.7080078125 @ 41.798919677734375;
		at: 24 put: 142.83999633789063 @ -177.908193821069;
		at: 25 put: 142.83999633789063 @ -177.908193821069;
		at: 26 put: 142.83999633789063 @ -177.908193821069;
		at: 27 put: 142.83999633789063 @ -177.908193821069;
		at: 28 put: 142.83999633789063 @ -177.908193821069;
		at: 29 put: 142.83999633789063 @ -177.908193821069;
		at: 30 put: 307.1600673675537 @ -133.40216064453125;
		at: 31 put: 307.1600673675537 @ -133.40216064453125;
		at: 32 put: 307.1600673675537 @ -133.40216064453125;
		at: 33 put: 307.1600673675537 @ -133.40216064453125;
		at: 34 put: 307.1600673675537 @ -133.40216064453125;
		at: 35 put: 307.1600673675537 @ -133.40216064453125;
		yourself
]
