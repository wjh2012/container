docker exec -it kafka-broker-1 kafka-topics.sh \
--describe --topic test --bootstrap-server \
ggomg.duckdns.org:59094


docker exec -it kafka-broker-1 kafka-topics.sh \
--list --bootstrap-server \
ggomg.duckdns.org:59094