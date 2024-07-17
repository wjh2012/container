docker exec -it kafka-broker-1 kafka-console-producer.sh \
--producer.config /opt/bitnami/kafka/config/producer.properties \
--bootstrap-server ggomg.duckdns.org:59094 --topic test