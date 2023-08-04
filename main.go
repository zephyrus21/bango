package main

import (
	"database/sql"
	"log"

	"bango/api"
	db "bango/db/sqlc"
	"bango/utils"

	_ "github.com/lib/pq"
)

func main() {
	config, err := utils.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	conn, err := sql.Open(config.DbDriver, config.DbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddr)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
