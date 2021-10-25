## first code cell
using DBInterface
using SQLite
using JuliaDB # for using table to neatly display data

# This code follows the tutorial found here: https://www.sqlitetutorial.net/sqlite-sample-database/

# Load a SQLite database from a file
# Run this script in the sqlite_demo folder so it finds the file
# TODO: Put an environment variable in here
db = SQLite.DB("chinook.db")

# Conventient aliases
sq = SQLite
sqexec = SQLite.DBInterface.execute

# TODO: Move these functions to a utility folder
function tsqexec(stmt)
    sqexec(stmt) |> table
end

function sqprep(db, query)
    DBInterface.prepare(db, query)
end

# Return the tables in the database
# Note: Any table beginning with sqlite_ is an internal table and not part of the real data
# See https://www.sqlite.org/fileformat2.html#intschema
sq.tables(db) |> table
## second code cell