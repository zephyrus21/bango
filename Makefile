postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=zephyrus -d postgres:alpine

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

.PHONY: postgres createdb dropdb migrateup migratedown sqlc