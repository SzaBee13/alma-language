const { DebugSession, LoggingDebugSession } = require("@vscode/debugadapter");
const { DebugProtocol } = require("@vscode/debugprotocol");
const path = require("path");

class AlmaDebugSession extends LoggingDebugSession {
    constructor() {
        super("alma-debugger.log");
    }

    initializeRequest(response, args) {
        response.body = response.body || {};
        response.body.supportsConfigurationDoneRequest = true;
        this.sendResponse(response);
    }

    launchRequest(response, args) {
        const { program } = args;

        // Futtassuk az `alma` parancsot a programmal
        const childProcess = require("child_process").spawn("alma", [program], {
            cwd: path.dirname(program),
        });

        childProcess.stdout.on("data", (data) => {
            this.sendEvent({
                event: "output",
                body: { output: data.toString() },
            });
        });

        childProcess.stderr.on("data", (data) => {
            this.sendEvent({
                event: "output",
                body: { output: data.toString(), category: "stderr" },
            });
        });

        childProcess.on("close", (code) => {
            this.sendEvent({ event: "end" });
        });

        this.sendResponse(response);
    }
}

DebugSession.run(AlmaDebugSession);
