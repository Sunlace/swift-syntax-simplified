import SwiftSyntax

extension SyntaxFactory.Simplified {

    public static func makeFunctionCallExpr(
        calledExpression: ExprSyntax,
        arguments: [TupleExprElementSyntax] = [],
        trailingClosure: TrailingClosureGroupSyntax? = nil
    ) -> FunctionCallExprSyntax {
        let skipArgumentList = arguments.isEmpty
            && !(trailingClosure?.includeEmptyArgumentListParentheses ?? true)

        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: calledExpression,
            leftParen: skipArgumentList ? nil : SyntaxFactory.makeLeftParenToken(),
            argumentList: makeTupleExprElementList(arguments),
            rightParen: skipArgumentList ? nil : SyntaxFactory.makeRightParenToken(),
            trailingClosure: trailingClosure?.trailingClosure,
            additionalTrailingClosures: trailingClosure?.additionalTrailingClosures.onlyIfNotEmpty.map {
                SyntaxFactory.makeMultipleTrailingClosureElementList($0)
            }
        )
    }

    public static func makeArrayExpr(
        elements: [ExprSyntax] = []
    ) -> ArrayExprSyntax {
        SyntaxFactory.makeArrayExpr(
            leftSquare: SyntaxFactory.makeLeftSquareBracketToken(),
            elements: makeArrayElementList(elements),
            rightSquare: SyntaxFactory.makeRightSquareBracketToken()
        )
    }

    public static func makeTupleExpr(
        elements: [TupleExprElementSyntax] = []
    ) -> TupleExprSyntax {
        SyntaxFactory.makeTupleExpr(
            leftParen: SyntaxFactory.makeLeftParenToken(),
            elementList: makeTupleExprElementList(elements),
            rightParen: SyntaxFactory.makeRightParenToken()
        )
    }

    public static func makeClosureExpr(
        signature: ClosureSignatureSyntax? = nil,
        statements: [CodeBlockItemSyntax] = []
    ) -> ClosureExprSyntax {
        SyntaxFactory.makeClosureExpr(
            leftBrace: SyntaxFactory.makeLeftBraceToken(),
            signature: signature,
            statements: SyntaxFactory.makeCodeBlockItemList(statements),
            rightBrace: SyntaxFactory.makeRightBraceToken()
        )
    }

    public static func makeSequenceExpr(
        elements: [ExprSyntax]
    ) -> SequenceExprSyntax {
        SyntaxFactory.makeSequenceExpr(
            elements: SyntaxFactory.makeExprList(elements)
        )
    }

    public static func makeAsExpr(
        questionOrExclamationMark: QuestionOrExclamationMarkTokenSyntax? = nil,
        typeName: TypeSyntax
    ) -> AsExprSyntax {
        SyntaxFactory.makeAsExpr(
            asTok: SyntaxFactory.makeAsKeyword(),
            questionOrExclamationMark: questionOrExclamationMark.map { $0.token },
            typeName: typeName
        )
    }

    public static func makeMemberAccessExpr(
        base: ExprSyntax? = nil,
        name: TokenSyntax,
        declNameArguments: DeclNameArgumentsSyntax? = nil
    ) -> MemberAccessExprSyntax {
        SyntaxFactory.makeMemberAccessExpr(
            base: base,
            dot: SyntaxFactory.makePeriodToken(),
            name: name,
            declNameArguments: declNameArguments
        )
    }

    public static func makeAssignmentExpr() -> AssignmentExprSyntax {
        SyntaxFactory.makeAssignmentExpr(
            assignToken: SyntaxFactory.makeEqualToken()
        )
    }
}
