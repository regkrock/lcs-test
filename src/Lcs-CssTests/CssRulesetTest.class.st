Class {
	#name : #CssRulesetTest,
	#superclass : #TestCase,
	#category : #'Lcs-CssTests'
}

{ #category : #test }
CssRulesetTest >> testCompressedCssOfBodyRuleset [
	| ruleset actual target|
	target := 'body{width:600px;margin:0 auto;background-color:#ff9500;padding:0 20px 20px 20px;border:5px solid black;}'.
	ruleset := CssRuleset new.
	ruleset
		selector: 'body';
		property: 'width' value: '600px';
		property: 'margin' value: '0 auto';
		property: 'background-color' value: '#ff9500';
		property: 'padding' value: '0 20px 20px 20px';
		property: 'border' value: '5px solid black'.
	self assert: ruleset declarations size = 5.
	actual := ruleset compressedCssString.
	self assert: actual equals: target

]

{ #category : #test }
CssRulesetTest >> testCompressedCssOfNestedRuleset [
	| ruleset target actual|
	target := 'nav ul{margin:0;padding:0;list-style:none;}nav li{display:inline-block;}nav a{display:block;padding:6px 12px;text-decoration:none;}'.
	ruleset := CssRuleset new.
	ruleset
		selector: 'nav';
		nestedSelector: 'ul' with: [:eachRuleset |
			eachRuleset
				property: 'margin' value: '0'; 
				property: 'padding' value: '0';
				property: 'list-style' value: 'none'];
		nestedSelector: 'li' with: [:eachRuleset |
			eachRuleset
				property: 'display' value: 'inline-block'];
		nestedSelector: 'a' with: [:eachRuleset |
			eachRuleset
				property: 'display' value: 'block';
				property: 'padding' value: '6px 12px';
				property: 'text-decoration' value: 'none'].
	self assert:ruleset declarations size = 0.
	self assert:ruleset nestedRulesets size = 3.
	
	actual := ruleset compressedCssString.
	self assert:target = actual


]

{ #category : #test }
CssRulesetTest >> testH1BoldRuleset [
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
	"((ReadStream on: actual) contents size) = ((ReadStream on: target) contents size) ifFalse: [self halt]."
	self assert: target = actual


]

{ #category : #test }
CssRulesetTest >> testNestedRuleset [
	| ruleset target actual|
	target := 'nav ul {
	margin: 0;
	padding: 0;
	list-style: none;
}
nav li {
	display: inline-block;
}
nav a {
	display: block;
	padding: 6px 12px;
	text-decoration: none;
}'.
	ruleset := CssRuleset new.
	ruleset
		selector: 'nav';
		nestedSelector: 'ul' with: [:eachRuleset |
			eachRuleset
				property: 'margin' value: '0';
				property: 'padding' value: '0';
				property: 'list-style' value: 'none'];
		nestedSelector: 'li' with: [:eachRuleset |
			eachRuleset
				property: 'display' value: 'inline-block'];
		nestedSelector: 'a' with: [:eachRuleset |
			eachRuleset
				property: 'display' value: 'block';
				property: 'padding' value: '6px 12px';
				property: 'text-decoration' value: 'none'].
	self assert:ruleset declarations size = 0.
	self assert:ruleset nestedRulesets size = 3.
	
	actual := ruleset prettyCssString.
	self assert:target = actual


]

{ #category : #test }
CssRulesetTest >> testPrettyCssOfBodyRuleset [
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
}'

]
