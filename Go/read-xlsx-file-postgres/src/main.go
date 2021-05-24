// xlsx etl to postgres
package main

import (
	"bufio"
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	"github.com/lib/pq"
	"github.com/tealeg/xlsx"
)

func main() {
	db := openSqlDb()
	xlsxToDb("file.xlsx", db)
}

// xlsx to db
func xlsxToDb(fileName string, db *sql.DB) {
	file, err := xlsx.OpenFile(fileName)
	if err != nil {
		panic(err)
	}
	if len(file.Sheets) > 1 {
		panic("expect 1 sheet")
	}
	sheet := file.Sheets[0]
	firstrow := sheet.Row(0)
	txn, err := db.Begin()
	if err != nil {
		panic(err)
	}
	stmt, _ := txn.Prepare(pq.CopyIn("table", firstrow.Cells[0].Value, firstrow.Cells[1].Value, firstrow.Cells[2].Value, firstrow.Cells[3].Value, firstrow.Cells[4].Value))

	for i := 1; i < sheet.MaxRow; i++ {
		row := sheet.Row(i)
		if _, err := stmt.Exec(row.Cells[0].Value, row.Cells[1].Value, row.Cells[2].Value, row.Cells[3].Value, row.Cells[4].Value); err != nil {
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

// convert xlsx to csv
func XlsxToCsv(fileName string) string {
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
				panic("error at line " + strconv.Itoa(irow) + " cell " + strconv.Itoa(icell))
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

// import csv into sql table
func CsvToDb(csvFileName string, db *sql.DB) {
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
	stmt, err := txn.Prepare(pq.CopyIn("table", records[0][:]...))
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
		server   = "localhost"
		port     = 5432
		user     = "postgres"
		password = "password"
		database = "my_first_db"
	)
	connString := fmt.Sprintf("user=%s password=%s host=%s port=%d dbname=%s sslmode=disable", user, password, server, port, database)
	conn, err := sql.Open("postgres", connString)
	if err != nil {
		panic("failed to open connection" + err.Error())
	}
	return conn
}
