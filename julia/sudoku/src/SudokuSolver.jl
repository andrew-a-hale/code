# decompose modules into many smaller modules?
# Sudoku
#   Solvers
#   Helpers
#   Validators
#   Precompute
module SudokuSolver

# Data Model
struct Config{T<:UInt8,S<:Array{UInt8}}
    zero::T
    one::T
    size::T
    rows::T
    value_set::S
    subgridsize::T
end

# bad data types?
mutable struct Sudoku{T<:Array{UInt8},S<:Array{Array{UInt8,1},1},R<:Array{Tuple{UInt8,UInt8},1}}
    current_grid::T
    fail_states::S
    changes::R
end

# Processing
function read_sudoku(input::String)
    input_subgridsize = sqrt(sqrt(length(input)))
    if (!isinteger(input_subgridsize)) 
        error("give sudoku has unsupported dimension")
    end
    parsed_grid = map(x -> parse(UInt8, x), split(replace(input, '.' => '0'), ""))
    Sudoku(parsed_grid, Array{UInt8,1}[], Tuple{UInt8,UInt8}[])
end

# Precomputation
function precomputation()
    context_indexes()
end

# Precomputation Helpers
function row_indexes()
    range_offset = config.rows - config.one
    map(x -> range(x * config.rows - range_offset, length = config.rows), range(config.one, length = config.rows))
end

function col_indexes()
    map(x -> range(x, step = config.rows, length = config.rows), range(config.one, length = config.rows))
end

## looks inefficient
function subgrid_indexes()
    function mapper(x) 
        row_start = floor_nearest(row_from_cell(x), config.subgridsize)
        col_start = floor_nearest(col_from_cell(x), config.subgridsize)
        subgrid_rows = range(row_start, step = config.one, length = config.subgridsize)
        subgrid_cols = range(col_start, step = config.one, length = config.subgridsize)
        row_indx = row_indexes()
        reduce(vcat, map(x -> x[subgrid_cols], row_indx[subgrid_rows]))
    end
    map(x -> mapper(x), range(config.one, length = config.size))
end

## looks inefficient
function context_indexes()
    map(
        cell -> vcat(
            row_indexes()[row_from_cell(cell)],
            col_indexes()[col_from_cell(cell)],
            subgrid_indexes()[cell]
        ),
        range(config.one, length = config.size)
    )
end

function setup_config(sudoku::Sudoku)
    gridsize::UInt8 = length(sudoku.current_grid)
    rows::UInt8 = sqrt(gridsize)
    value_set::Array{UInt8} = range(0x01, length = rows)
    subgridsize::UInt8 = sqrt(rows)
    Config(0x00, 0x01, gridsize, rows, value_set, subgridsize)
end

# Solver
function run_solver(sudoku::Sudoku)
    while !is_solved(sudoku)
        sudoku = solve(sudoku)
    end
    sudoku
end

## decompose into smaller functions
function solve(sudoku::Sudoku)
    if is_solved(sudoku) 
        return sudoku
    end

    # need to filter candidates
    # if in a whole row, col, or grid a cell value is unique it is the only candidate for cell
    all_candidates = map(cell -> get_candidates(sudoku.current_grid, cell), range(config.one, length = config.size))

    indexes_to_change::UInt8 = 0x00
    # rewrite as function
    for cell ∈ eachindex(all_candidates)
        if !isnothing(all_candidates[cell]) && length(all_candidates[cell]) == 1
            indexes_to_change = cell
        end
    end

    # rewrite as validator?
    error = !isnothing(findfirst(cell -> isnothing(all_candidates[cell]) && sudoku.current_grid[cell] == config.zero, range(config.one, length = config.size)))

    # rewrite as validator
    if indexes_to_change > 0
        proposed_change = deepcopy(sudoku.current_grid)
        proposed_change[indexes_to_change] = all_candidates[indexes_to_change][1]
        if proposed_change ∈ sudoku.fail_states
            error = true
        end
    end

    if error
        sudoku = update_fail_states(sudoku)
        sudoku = revert_last_change(sudoku)
        return sudoku
    end

    # rewrite as make_move(:Int)
    if indexes_to_change > 0
        sudoku.current_grid[indexes_to_change] = all_candidates[indexes_to_change][1]
        sudoku = update_changes(sudoku, (indexes_to_change, all_candidates[indexes_to_change][1]))
    end

    # rewrite as make_move(:Nothing)
    if indexes_to_change == 0 && config.zero ∈ sudoku.current_grid
        cell = findfirst(iszero, sudoku.current_grid) # add heuristic here to complete the most solved cell
        sudoku = make_guess(sudoku, cell)
    end

    return sudoku
end

# Solve Subroutines
function update_fail_states(sudoku)
    if sudoku.current_grid ∉ sudoku.fail_states 
        push!(sudoku.fail_states, deepcopy(sudoku.current_grid))
    end
    sudoku
end

function update_changes(sudoku, last_change)
    push!(sudoku.changes, last_change)
    sudoku
end

function revert_last_change(sudoku)
    cell, value = pop!(sudoku.changes)
    sudoku.current_grid[cell] = config.zero
    sudoku
end

function get_candidates(grid, cell)
    if grid[cell] > config.zero
        return nothing
    end
    context = get_context(grid, cell)
    candidates = setdiff(config.value_set, context)
    length(candidates) > 0 ? candidates : nothing
end

function make_guess(sudoku, cell) 
    candidates = get_candidates(sudoku.current_grid, cell)
    if !isnothing(candidates)
        for candidate ∈ candidates
            sudoku.current_grid[cell] = candidate
            if (sudoku.current_grid ∉ sudoku.fail_states)
                sudoku = update_changes(sudoku, (cell, candidate))
                return sudoku
            end
        end
    end
    # in fail state
    sudoku.current_grid[cell] = config.zero
    sudoku = update_fail_states(sudoku)
    sudoku = revert_last_change(sudoku)
    sudoku
end

# Validators
function is_solved(sudoku::Sudoku)
    # basic completion check
    if (config.zero ∈ sudoku.current_grid)
        return false
    elseif !validate_grid(sudoku.current_grid)
        return false
    end
    true
end

function validate_grid(grid)
    all(i -> validate_context(get_context(grid, i)), range(config.one, length = config.size))
end

function validate_context(context) 
    row, col, subgrid = collect(Iterators.partition(context, config.rows))
    all(i -> length(unique(context[i])) == config.rows, [row, col, subgrid])
end

# Helpers
function row_from_cell(cell)
    (cell - config.one) ÷ config.rows + config.one
end

function col_from_cell(cell)
    (cell - config.one) % config.rows + config.one
end

function floor_nearest(x, n) 
    (((x - config.one) ÷ n) * n) + config.one
end

function get_context(grid, cell)
    grid[cell_contexts[cell]]
end

# Print
function print(sudoku::Sudoku)
    for i ∈ range(config.one, length = config.size)
        if i % config.rows === config.zero
            println(sudoku.current_grid[i])
        else
            Base.print(sudoku.current_grid[i], " ")
        end
    end
end

# Example
const example_grid = ".....6....59.....82....8....45........3........6..3.54...325..6.................."
sudoku = read_sudoku(example_grid)
const config = setup_config(sudoku)
const cell_contexts = precomputation()
@time print(run_solver(sudoku))

end
