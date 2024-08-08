docker exec -it rebbitmq2 rabbitmqctl stop_app
docker exec -it rebbitmq2 rabbitmqctl reset
docker exec -it rebbitmq2 rabbitmqctl join_cluster rabbit@rebbitmq1
docker exec -it rebbitmq2 rabbitmqctl start_app

docker exec -it rebbitmq3 rabbitmqctl stop_app
docker exec -it rebbitmq3 rabbitmqctl reset
docker exec -it rebbitmq3 rabbitmqctl join_cluster rabbit@rebbitmq1
docker exec -it rebbitmq3 rabbitmqctl start_app