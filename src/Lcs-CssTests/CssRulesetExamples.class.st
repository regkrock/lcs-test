Class {
	#name : #CssRulesetExamples,
	#superclass : #Object,
	#category : #'Lcs-CssTests'
}

{ #category : #example }
CssRulesetExamples >> bodyRuleset [
	<gtExample>
	<noTest>
	| ruleset |
	ruleset := CssRuleset new.
	ruleset
		selector: 'body';
		property: 'width' value: '600px';
		property: 'margin' value: '0 auto';
		property: 'background-color' value: '#ff9500';
		property: 'padding' value: '0 20px 20px 20px';
		property: 'border' value: '5px solid black'.
	self assert: ruleset declarations size = 5.
	self assert: ruleset prettyCssString equals: 'body {
	width: 600px;
	margin: 0 auto;
	background-color: #ff9500;
	padding: 0 20px 20px 20px;
	border: 5px solid black;
}'.
	^ruleset

]

{ #category : #example }
CssRulesetExamples >> h1BoldRuleset [
	<gtExample>
	<noTest>
	| ruleset target actual|
	target := 'h1 {
	margin: 0;
	padding: 20px 0;
	color: #00539f;
	text-shadow: 3px 3px 1px black;
}'.
	ruleset := CssRuleset new.
	ruleset
		selector: 'h1';
		property: 'margin' value: '0';
		property: 'padding' value: '20px 0';
		property: 'color' value: '#00539f';
		property: 'text-shadow' value: '3px 3px 1px black'.
	self assert: ruleset declarations size = 4.
	actual := ruleset prettyCssString.
	self assert: target equals: actual.
	^ruleset


]
