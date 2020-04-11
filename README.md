# everyday-life-with-clojure-spec

[clojure.spec](https://clojure.org/guides/spec) examples.

## Developing

### Prerequisites

- [Java (JDK)](http://openjdk.java.net/)
    - `java -version` >= 11
- [Leiningen](https://leiningen.org/) or [Clojure CLI](https://clojure.org/guides/deps_and_cli)
- [Docker](https://www.docker.com/)

### Database

```sh
# Start local DB
$ docker-compose up -d
# Import DB schema
$ PGPASSWORD=password123 psql -h127.0.0.1 -p5442 -Uaqoursql_dev -daqoursql < sql/ddl/aqoursql.sql
$ PGPASSWORD=password123 psql -h127.0.0.1 -p5443 -Uaqoursql_dev -daqoursql_test < sql/ddl/aqoursql.sql
# Seed DB
$ PGPASSWORD=password123 psql -h127.0.0.1 -p5442 -Uaqoursql_dev -daqoursql < sql/dml/seed.sql
```
