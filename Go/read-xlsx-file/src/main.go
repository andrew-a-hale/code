// xlsx etl to db
package main

import (
	"bufio"
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
	"time"

	mssql "github.com/denisenkom/go-mssqldb"
	"github.com/tealeg/xlsx"
)

func main() {
	csvFileName := xlsxToCsv("file.xlsx")
	checkCsv(csvFileName)

	db := openSqlDb()

	csvToDb(csvFileName, db)
}

// convert xlsx to csv
func xlsxToCsv(fileName string) string {
	const lineTerminator = "\r\n"
	file, err := xlsx.OpenFile(fileName)
	if err != nil {
		panic(err)
	}
	if len(file.Sheets) > 1 {
		panic("expect 1 sheet")
	}
	sheet := file.Sheets[0]
	fo, err := os.Create(sheet.Name + ".csv")
	if err != nil {
		panic("couldn't open file for " + sheet.Name)
	}
	w := bufio.NewWriter(fo)
	for irow, row := range sheet.Rows {
		for icell, cell := range row.Cells {
			// write value to file
			v := cell.String()
			// append comma if not last column
			if icell < sheet.MaxCol-1 {
				v += ","
			}
			if _, err := w.Write([]byte(v)); err != nil {
				panic("error at line " +
					strconv.Itoa(irow) +
					" cell " +
					strconv.Itoa(icell))
			}
		}
		// add line terminator
		if _, err := w.Write([]byte(lineTerminator)); err != nil {
			panic("failed to add line terminator for row " + strconv.Itoa(irow))
		}
	}
	if err = w.Flush(); err != nil {
		panic(err)
	}
	fo.Close()
	return fo.Name()
}

// validate csv return nil or error
func checkCsv(csv string) {
	os.Chtimes(csv, time.Now(), time.Now())
	// add more here later
}

// import csv into sql table
func csvToDb(csvFileName string, db *sql.DB) {
	f, _ := os.Open(csvFileName)
	rs := csv.NewReader(f)
	records, err := rs.ReadAll()
	if err != nil {
		panic(err)
	}
	txn, err := db.Begin()
	if err != nil {
		panic(err)
	}
	stmt, err := txn.Prepare(mssql.CopyIn("table", mssql.BulkOptions{}, records[0][:]...))
	if err != nil {
		panic(err)
	}
	for _, row := range records[1:] {
		if _, err := stmt.Exec(row[0], row[1], row[2], row[3], row[4]); err != nil {
			panic(err)
		}
	}

	result, err := stmt.Exec()
	if err != nil {
		panic(err)
	}
	if err := stmt.Close(); err != nil {
		panic(err)
	}
	if err := txn.Commit(); err != nil {
		panic(err)
	}
	rowCount, _ := result.RowsAffected()
	print(rowCount)
	println(" row copied")
}

// open and return a sql db
func openSqlDb() *sql.DB {
	const (
		server   = "server"
		port     = 1111
		user     = "user"
		password = "password"
		database = "database"
	)
	connString := fmt.Sprintf("server=%s;user id=%s;password=%s;port=%d;database=%s", server, user, password, port, database)
	conn, err := sql.Open("mssql", connString)
	if err != nil {
		panic("failed to open connection" + err.Error())
	}
	return conn
}
