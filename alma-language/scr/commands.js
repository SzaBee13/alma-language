const vscode = require('vscode');

function provideCompletionItems(document, position, token, context) {
    const completionItems = [
        new vscode.CompletionItem('alma', vscode.CompletionItemKind.Function),
        new vscode.CompletionItem('eat', vscode.CompletionItemKind.Variable),
        new vscode.CompletionItem('make', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('ate', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('else', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('fin', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('true', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('false', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('null', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('for', vscode.CompletionItemKind.Keyword),
        new vscode.CompletionItem('while', vscode.CompletionItemKind.Keyword),
        // További parancsok itt
    ];
    
    return completionItems;
}

module.exports = {
    provideCompletionItems
};
