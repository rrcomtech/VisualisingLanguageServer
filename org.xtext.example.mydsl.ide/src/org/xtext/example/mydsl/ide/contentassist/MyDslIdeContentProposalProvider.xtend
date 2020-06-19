package org.xtext.example.mydsl.ide.contentassist

import com.google.inject.Inject
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.ide.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ide.editor.contentassist.IIdeContentProposalAcceptor
import org.eclipse.xtext.ide.editor.contentassist.IdeContentProposalProvider
import org.eclipse.xtext.scoping.IScopeProvider
import org.xtext.example.mydsl.services.MyDslGrammarAccess
import org.xtext.example.mydsl.myDsl.MyDslPackage

class MyDslIdeContentProposalProvider extends IdeContentProposalProvider {

	@Inject extension MyDslGrammarAccess

	@Inject IScopeProvider scopeProvider

	override protected _createProposals(RuleCall ruleCall, ContentAssistContext context,
		IIdeContentProposalAcceptor acceptor) {

		// Considered Alternatives
		if (decisionRecordRule == ruleCall.rule && context.currentModel !== null) {
			
			acceptor.accept(proposalCreator.createSnippet('''Title: 
"How do we solve the problem XYZ?"

User story: 
"Ticket-123"

Summary: 
"Write your summary here"
				
Considered alternatives: 
ALT_N1: "Write your 1st alternative here"
ALT_N2: "Write your 2nd alternative here"
ALT_N3: "Write your 3rd alternative here"
				
We chose: 
ALT_N3

Because: 
"HERE COMES YOUR RATIONALE"''', "Complete Template", context), 0)
		}

		// Considered Alternatives
		if (alternativesRule == ruleCall.rule && context.currentModel !== null) {
//			acceptor.accept(proposalCreator.createSnippet('''Considered alternatives: 
//${1:alternatives}
//${2:"Write your 2nd alternative here"}''', "Provide a 2nd alternative", context), 0)
			acceptor.accept(proposalCreator.createSnippet('''Considered alternatives: 
ALT_N1: "Write your 1st alternative here"
ALT_N2: "Write your 2nd alternative here"''', "Provide 2 alternatives", context), 0)
			acceptor.accept(proposalCreator.createSnippet('''Considered alternatives: 
ALT_N1: "Write your 1st alternative here"
ALT_N2: "Write your 2nd alternative here"
ALT_N3: "Write your 3rd alternative here"''', "Provide 3 alternatives", context), 0)
		}

		// Considered Alternatives
		if (alternativeRule == ruleCall.rule && context.currentModel !== null) {
			val scope = scopeProvider.getScope(context.currentModel, MyDslPackage.Literals.ALTERNATIVES__ALTERNATIVES)
			acceptor.accept(proposalCreator.createSnippet('''ALT_N«scope.allElements.size+1» "Write your next alternative here"''', "Provide another alternative", context), 0)
		}


		// Summary		
		if (summaryRule == ruleCall.rule && context.currentModel !== null) {
			acceptor.accept(
				proposalCreator.createSnippet('''Summary: 
"Write your summary here"''', "Provide a summary", context),
				0)
		}

		// User Story		
		if (userStoryRule == ruleCall.rule && context.currentModel !== null) {
			acceptor.accept(
				proposalCreator.createSnippet('''User story: 
"Ticket-123"''', "Provide a ticket ID", context), 0)
		}

		// Title
		if (titleRule == ruleCall.rule && context.currentModel !== null) {
			acceptor.accept(
				proposalCreator.createSnippet('''Title: 
"How do we solve the problem XYZ?"''',
					"Provide a title", context), 0)
		}

		// outcome
		if (outcomeRule == ruleCall.rule && context.currentModel !== null) {
			val scope = scopeProvider.getScope(context.currentModel, MyDslPackage.Literals.OUTCOME__SELECTED)
			acceptor.accept(proposalCreator.createSnippet('''We chose:
"«scope.allElements.map[name.toString]»"''', "Specify your selected alternative", context), 0)
		}

//		// chosenAlternative
//		if (chosenAlternativeRule == ruleCall.rule && context.currentModel !== null) {
//			acceptor.accept(proposalCreator.createSnippet('''""''', "Chosen alternative template -- Compact", context),
//				0)
//		}

		if (becauseRule == ruleCall.rule && context.currentModel !== null) {
//			val scope = scopeProvider.getScope(context.currentModel, MyDslPackage.Literals.OUTCOME__BECAUSE)
//			if (scope.allElements.get(0) === null) {
			acceptor.accept(
				proposalCreator.createSnippet('''Because: 
"HERE COMES YOUR RATIONALE"''',
					"Provide rationale", context), 0)
//			}
		}

		if (rationaleRule == ruleCall.rule && context.currentModel !== null) {
			val scope = scopeProvider.getScope(context.currentModel, MyDslPackage.Literals.OUTCOME__BECAUSE)
			if (scope.allElements !== null) {
				acceptor.accept(
					proposalCreator.createSnippet('''"HERE COMES YOUR RATIONALE"''', "Provide rationale",
						context), 0)
			}
		}

		super._createProposals(ruleCall, context, acceptor)
	}

}
