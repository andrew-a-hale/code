## Things to learn
* Using vscode with R
    + This doesn't seem worthwhile for R package development...
    + Dissatisfaction with R grows for production code.
    ```yaml 
    {
        "python.linting.enabled": false,
        "files.autoSave": "afterDelay",
        "editor.wordWrap": "on",
        "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\cmd.exe",
        "liveServer.settings.donotShowInfoMsg": true,
        "window.menuBarVisibility": "classic",
        "workbench.statusBar.visible": true,
        "window.zoomLevel": -1,
        "terminal.integrated.commandsToSkipShell": [
            "language-julia.interrupt"
        ],
        "julia.enableTelemetry": false,
        "git.confirmSync": false,
        "git.autofetch": true,
        "r.rterm.windows": "C:\\Users\\derpi\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\radian.exe",
        "r.sessionWatcher": true,
        "r.workspaceViewer.removeHiddenItems": true,
        "task.problemMatchers.neverPrompt": false,
        "r.lsp.debug": true,
        "r.lsp.diagnostics": true,
        "r.rterm.option": [
            "--no-save",
            "--no-restore",
            "--r-binary=C:\\Program Files\\R\\R-4.0.3\\bin\\R.exe"
        ],
        "r.rpath.windows": "C:\\Program Files\\R\\R-4.0.3\\bin\\R.exe",
        "editor.minimap.maxColumn": 80,
        "[r]": {
            "editor.rulers": [80]
        },
        "[julia]": {
            "editor.rulers": [80]
        },
        "[go]": {
            "editor.rulers": [80]
        },
        "[python]": {
            "editor.rulers": [80]
        },
        "editor.fontFamily": "JetBrains Mono NL",
        "editor.fontSize": 13,
        "editor.fontLigatures": true,
        "go.toolsManagement.autoUpdate": true,
        "r.bracketedPaste": true,
        "r.source.focus": "none",
        "terminal.integrated.cursorStyle": "underline",
        "terminal.integrated.rendererType": "canvas",
        "editor.tabSize": 2,
        "diffEditor.ignoreTrimWhitespace": false
    }
    ```
* vim
    + https://danielmiessler.com/study/vim/
* Go 
    + The Go Programming Language
    + Go In Action
* Julia
    + https://julialang.org/learning/
    + Mux.jl
    + DataFrames.jl / DataTable.jl
    + Gadfly.jl
    + Octo.jl
* Postgresql

## Things to look into
* Elixir 
    + Elixir In Action
* Erlang
    + https://learnyousomeerlang.com/
* Rust
* Elm
    + Elm In Action
* Haskell
    + http://learnyouahaskell.com/
* Parquet

## Small learning projects
* Go
    + Discord Bot
    + Webserver with Postgesql
* Julia 
    + Webserver with Postgesql
    + Sudoku Solver

## Go Discord Bot
Should have built in commands and be able to create new command that return urls.

## Go Webserver
Simple API for a Postgresql server that can Select, Update, Insert, Delete. 
Select should return JSON, CSV, or Parquet.
Should be able to PUT JSON, CSV, or Parquet data into the Database

## Julia Webserver
Simple API for a Postgresql server that can Select, Update, Insert, Delete.
Select should return JSON, CSV, or Parquet.
Should be able to PUT JSON, CSV, or Parquet data into the Database
