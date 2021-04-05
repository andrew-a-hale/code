module SudokuSolver

# Example
const example_grid = "001073280250980030098600004043200910100030005079008360700005620010067058085410700"

# Data Model
struct Config 
    size::Int
    rows::Int
    value_set::Array{Int, 1}
    subgridsize::Int
end

struct Sudoku
    current_grid::Array{Int, 1}
    init_grid::Array{Int, 1}
    fail_states::Array{Int, 1}
    changes::Array{Int, 2}
end

struct GridIndexes
    row
    col
    subgrid
    context_indexes
end

# Processing
function read_sudoku(input::String)
    input_subgridsize = sqrt(sqrt(length(input)))
    if (!isinteger(input_subgridsize)) 
        error("give sudoku has unsupported dimension")
    end
    parsed_grid::Array{Int, 1} = map(x -> parse(Int, x), split(input, ""))
    Sudoku(parsed_grid, parsed_grid, [], [[] []])    
end

# Precomputation
function precomputation()
    GridIndexes(
        row_indexes(),
        col_indexes(),
        subgrid_indexes(),
        context_indexes()
    )
end

# Precomputation Helpers
function row_indexes()
    range_offset = config.rows - 1
    map(x -> range(x * config.rows - range_offset, length = config.rows), range(1, length = config.rows))
end

function col_indexes()
    map(x -> range(x, step = config.rows, length = config.rows), range(1, length = config.rows))
end

function subgrid_indexes()
    function mapper(x) 
        row_start = ((row_from_cell(x) - 1) ÷ config.subgridsize) * config.subgridsize + 1
        col_start = ((col_from_cell(x) - 1) ÷ config.subgridsize) * config.subgridsize + 1
        subgrid_rows = range(row_start, step=1, length=3)
        subgrid_cols = range(col_start, step=1, length=3)
        row_indx = row_indexes()
        map(x -> x[subgrid_cols], row_indx[subgrid_rows])
    end
    map(x -> mapper(x), range(1, length = config.size))
end

# TODO: should return an array of length 27
function context_indexes()
    map(
        cell -> vcat(
            row_indexes()[row_from_cell(cell)],
            col_indexes()[col_from_cell(cell)],
            subgrid_indexes()[cell]
        ),
        range(1, length = config.size)
    )
end

function setup_config(sudoku::Sudoku)
    grid = sudoku.init_grid
    rows::Int = sqrt(length(grid))
    value_set = range(1, length = rows)
    subgridsize::Int = sqrt(rows)
    Config(length(grid), rows, value_set, subgridsize)
end

# Solver
function run_solver(input)
    sudoku = read_sudoku(input)
    config = setup_config(sudoku)

    while !is_solved(sudoku)
        sudoku = solve(sudoku)
    end
end

function solve(sudoku::Sudoku)
    1
end

# Solve Subroutines

# Validators
function is_solved(sudoku::Sudoku) 
    grid = sudoku.current_grid
    # basic completion check
    if (0 ∈ grid)
        return false
    end
    true
end

# Sudoku Helpers
function row_from_cell(cell)
    (cell - 1) ÷ config.rows + 1
end

function col_from_cell(cell)
    (cell - 1) % config.rows + 1
end

# Print
function print(sudoku::Sudoku)
    for i ∈ range(1, length = config.size)
        if i % config.rows == 0 
            println(sudoku.current_grid[i])
        else
            Base.print(sudoku.current_grid[i], " ")
        end
    end
end

sudoku = read_sudoku(example_grid)
const config = setup_config(sudoku)
grid_indexes = precomputation()
print(sudoku)

end
