## Things to learn
* Using vscode with R
    + https://medium.com/analytics-vidhya/a-fresh-start-for-r-in-vscode-ec61ed108cf6 
    + r.rpath.windows should be r exe path
    + r.rterm.windows should be radian
    + https://stackoverflow.com/questions/29968499/vertical-rulers-in-visual-studio-code
    ```json 
    {
        "r.rterm.windows": "C:\\Users\\derpi\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\radian.exe",
        "r.bracketedPaste": true,
        "r.sessionWatcher": true,
        "r.workspaceViewer.removeHiddenItems": true,
        "task.problemMatchers.neverPrompt": null,
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
        "editor.fontLigatures": true
    }
    ```
* vim
    + https://danielmiessler.com/study/vim/
* Go 
    + The Go Programming Language
    + Go In Action
* Julia
    + https://julialang.org/learning/
    + Mux.jl -- Webserver
    + DataFrames.jl / DataTable.jl -- Data Manipulation
    + Gadfly.jl -- Data Visualisation
    + Octo.jl -- Database Driver
* Postgresql

## Things to look into
* Elixir -- Elixir In Action
* Erlang -- https://learnyousomeerlang.com/
* Rust
* Elm -- Elm In Action
* Parquet

## Small learning projects
* Go
    + Discord Bot
    + Webserver with Postgesql
* Julia 
    + Webserver with Postgesql

## Go Discord Bot
placeholder

## Go Webserver
Simple API for a Postgresql server that can Select, Update, Insert, Delete. 
Select should return JSON, CSV, or Parquet.
Should be able to PUT JSON, CSV, or Parquet data into the Database

## Julia Webserver
Simple API for a Postgresql server that can Select, Update, Insert, Delete.
Select should return JSON, CSV, or Parquet.
Should be able to PUT JSON, CSV, or Parquet data into the Database
