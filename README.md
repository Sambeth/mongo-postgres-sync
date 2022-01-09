# MongoDB Sync to PostgresDB using Airbyte


## Prerequisite
Make sure you have docker installed.

## Instructions
1. Create docker network.
```bash
docker network create <network-name>
```

2. Clone this repository and `cd` into the project directory.

3. Edit the docker-compose.yaml file by adding the following;
```docker
networks:
  default:
    external:
      name: <network name>
```

4. Run the command below to build mongdb and postgresdb docker images and run containers.
```bash
docker compose up -d
```

5. Use a database client to connect to the MongoDB and PostgresDB containers using the credentials in the docker-compose.yml file.

6. Go to the [Airbyte](https://github.com/airbytehq/airbyte) github repository, clone it and `cd` into the project directory.

7. Edit the docker-compose.yaml file by adding the following;
```docker
networks:
  default:
    external:
      name: <network name>
```
NOTE: This is to ensure MongoDB, PostgresDB and Airbyte containers are all in the same network for easy communication.

8. Run the command below to build Airbyte docker images and run containers.
```bash
docker compose up
```

9. Now visit http://localhost:8000, click `Sources` and set up your MongoDB as source. Since MongoDB is in the same network with Airbyte you need to use the MongoDB container's IP address as `host` value. Next, click `Destinations` and set up your PostgresDB as destination. Likewise PostgresDB is in the same network with Airbyte you need to use the PostgresDB container's IP address as `host` value.
