docker exec -it kafka-server kafka-console-consumer.sh \
--consumer.config /opt/bitnami/kafka/config/consumer.properties \
--bootstrap-server ggomg.duckdns.org:59094 --topic test --from-beginning