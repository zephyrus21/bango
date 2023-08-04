postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=zephyrus -d postgres:alpine

startdb:
	docker start postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root bango

dropdb:
	docker exec -it postgres dropdb bango

migrateup:
	migrate -path db/migration -database "postgresql://root:zephyrus@localhost:5432/bango?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:zephyrus@localhost:5432/bango?sslmode=disable" -verbose down

sqlc:
	 sqlc generate
	
test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/zephyrus21/bango/db/sqlc Store

.PHONY: postgres startdb createdb dropdb migrateup migratedown sqlc server mock