const vscode = require("vscode");
const path = require("path");

function activate(context) {
    // Regisztráljuk a debugger-t
    context.subscriptions.push(
        vscode.debug.registerDebugAdapterDescriptorFactory("alma", {
            createDebugAdapterDescriptor: (session) => {
                // Debugger adapter futtatása Node.js-en keresztül
                const adapterExecutable = {
                    command: "node",
                    args: [
                        path.join(context.extensionPath, "dist", "adapter.js"),
                    ],
                };
                return new vscode.DebugAdapterExecutable(
                    adapterExecutable.command,
                    adapterExecutable.args
                );
            },
        })
    );

    vscode.window.showInformationMessage("Alma Debugger activated!");
}

function deactivate() {}

module.exports = {
    activate,
    deactivate,
};
