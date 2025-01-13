const vscode = require('vscode');

function activate(context) {
  let disposable = vscode.commands.registerCommand('alma.sayHello', () => {
    vscode.window.showInformationMessage('Hello from Alma Language!');
  });

  context.subscriptions.push(disposable);
}

function deactivate() {}

module.exports = {
  activate,
  deactivate
};
