Class {
	#name : #LcsBaselinesShouldProperlySpecifyDependencies,
	#superclass : #GtPharoConstraint,
	#category : #'Lcs-Tools'
}

{ #category : #example }
LcsBaselinesShouldProperlySpecifyDependencies class >> blocSpartaPackageAnalysisExample [
	"<gtExample>
	| analyzer packageAnalyzers blocSpartaPackageAnaluser |
	analyzer :=GtDependencyAnalyzerEasy analyzeBaseline: BaselineOfBloc.

	packageAnalyzers := analyzer directlyDefinedPackagesWithContext: GtDependencyAnalyzerContext new.

	blocSpartaPackageAnaluser := packageAnalyzers detect: [ :aPackageAnalyser | aPackageAnalyser name = 'Bloc-Sparta' ].
	
	^ blocSpartaPackageAnaluser"
]

{ #category : #accessing }
LcsBaselinesShouldProperlySpecifyDependencies >> issues [
	| gtProject allDependencies analyzers |
	gtProject := #BaselineOfLcsBase asClass gtRlProjectWithRepository: 'github//regkrock/lcs-base:main.src'.
	"'https://github.com/regkrock/lcs-base/src'"
	"github://feenkcom/gtoolkit:main/src'"
	allDependencies := gtProject withAllChildProjects.

	analyzers := allDependencies collect: [:aProject |
		(GtDependencyAnalyzerForBaseline new 
			baseline: aProject baselineClass)
			preloadedBaselines: aProject baselineClass gtDependencyAnalysisPreloadedBaselines ].

	^ analyzers select: [ :aBaselineAnalizer | 
		(aBaselineAnalizer issuesWithContext: GtDependencyAnalyzerContext new) size > 0 ]
	
]

{ #category : #accessing }
LcsBaselinesShouldProperlySpecifyDependencies >> name [
	^ 'Baselines should properly define project dependencies'
]

{ #category : #accessing }
LcsBaselinesShouldProperlySpecifyDependencies >> status [ 
	^ GtNeutralConstraintStatus new
]
