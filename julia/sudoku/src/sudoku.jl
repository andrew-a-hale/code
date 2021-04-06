module SudokuSolver

# Example
const example_grid = "001073280250980030098600004043200910100030005079008360700005620010067058085410700"

# Data Model
struct Config 
    size::Int
    rows::Int
    value_set::Array{Int}
    subgridsize::Int
end

mutable struct Sudoku
    current_grid::Array{Int}
    init_grid::Array{Int}
    fail_states
    changes
end

# Processing
function read_sudoku(input::String)
    input_subgridsize = sqrt(sqrt(length(input)))
    if (!isinteger(input_subgridsize)) 
        error("give sudoku has unsupported dimension")
    end
    parsed_grid = map(x -> parse(Int, x), split(input, ""))
    Sudoku(parsed_grid, parsed_grid, [], [])
end

# Precomputation
function precomputation()
    context_indexes()
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
        row_start = floor_nearest(row_from_cell(x), config.subgridsize)
        col_start = floor_nearest(col_from_cell(x), config.subgridsize)
        subgrid_rows = range(row_start, step=1, length=3)
        subgrid_cols = range(col_start, step=1, length=3)
        row_indx = row_indexes()
        reduce(vcat, map(x -> x[subgrid_cols], row_indx[subgrid_rows]))
    end
    map(x -> mapper(x), range(1, length = config.size))
end

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
function run_solver(sudoku::Sudoku)
    while !is_solved(sudoku)
        sudoku = solve(sudoku)
    end
    sudoku
end

function solve(sudoku::Sudoku)
    all_candidates = map(cell -> get_candidates(sudoku.current_grid, cell), range(1, length = config.size))
    index_to_change = 0
    for cell ∈ eachindex(all_candidates)
        if length(all_candidates[cell]) == 1
            index_to_change = cell
            break
        end
    end

    error = !isnothing(findfirst(cell -> isnothing(all_candidates[cell]) && sudoku.current_grid[cell] == 0, range(1, length = config.size)))

    if index_to_change > 0
        proposed_change = deepcopy(sudoku.current_grid)
        proposed_change[index_to_change] = all_candidates[index_to_change] # fails here
        if proposed_change ∈ sudoku.fail_states
            error = true
        end
    end

    if error
        println(2)
        sudoku = update_fail_states(sudoku)
        sudoku = revert_last_change(sudoku)
        return sudoku
    end

    if index_to_change > 0
        sudoku.current_grid[index_to_change] = all_candidates[index_to_change]
        sudoku = update_changes(sudoku, (index_to_change, all_candidates[index_to_change]))
    end

    if index_to_change == 0
        cell = findfirst(iszero, sudoku.current_grid)
        sudoku = make_guess(sudoku, cell)
    end

    solve(sudoku)
end

# Solve Subroutines
function update_fail_states(sudoku)
    unique!(push!(sudoku.fail_states, sudoku.current_grid))
    sudoku
end

function update_changes(sudoku, last_change)
    push!(sudoku.changes, last_change)
    sudoku
end

function revert_last_change(sudoku)
   cell, value = pop!(sudoku.changes)
   sudoku.current_grid[cell] = value
   sudoku
end

function get_candidates(grid, cell)
    context = get_context(grid, cell)
    candidates = setdiff(config.value_set, context)
    length(candidates) > 0 ? candidates : nothing
end

function make_guess(sudoku, cell) 
    candidates = get_candidates(sudoku.current_grid, cell)
    for candidate ∈ candidates
        sudoku.current_grid[cell] = candidate
        if (sudoku.current_grid ∉ sudoku.fail_states)
            sudoku = update_changes(sudoku, (cell, candidate))
            return sudoku
        end
    end
    # in fail state
    sudoku.current_grid[cell] = 0
    sudoku = update_fail_states(sudoku)
    sudoku = revert_last_change(sudoku)
    sudoku
end

# Validators
function is_solved(sudoku::Sudoku) 
    grid = sudoku.current_grid
    # basic completion check
    if (0 ∈ grid)
        return false
    elseif !validate_grid(grid)
        return false
    end
    true
end

function validate_grid(grid)
    all(i -> validate_context(get_context(grid, i)), range(1, length = config.size))
end

function validate_context(context) 
    row, col, subgrid = collect(Iterators.partition(context, config.rows))
    all(i -> length(unique(context[i])) == config.rows, [row, col, subgrid])
end

# Sudoku Helpers
function row_from_cell(cell)
    (cell - 1) ÷ config.rows + 1
end

function col_from_cell(cell)
    (cell - 1) % config.rows + 1
end

function floor_nearest(x, n) 
    (((x - 1) ÷ n) * n) + 1
end

function get_context(grid, cell)
    grid[cell_contexts[cell]]
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
const cell_contexts = precomputation()
print(run_solver(sudoku))

end
