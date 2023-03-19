# Kafka head-of-line blocking experiment

For context, please read [Experiments with Kafka's head-of-line blocking](https://www.artur-rodrigues.com/tech/2023/03/21/kafka-head-of-line-blocking.html).

To setup the experiment:

```
$ docker-compose up --build --force-recreate --renew-anon-volumes --remove-orphans --no-attach=kafka
```

In a different terminal:

```
$ bundle exec ruby producer.rb
```

To inspect the consumer group, attach to the Kafka server container and run:

```
$ docker exec -it $(docker ps --filter=name=queue-kafka-1 --quiet) bas
$ kafka-consumer-groups.sh --describe --group main-group --bootstrap-server localhost:9092
```
