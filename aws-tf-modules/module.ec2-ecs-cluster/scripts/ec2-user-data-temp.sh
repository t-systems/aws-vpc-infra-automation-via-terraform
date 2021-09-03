#!/usr/bin/env bash

echo ECS_CLUSTER=${health_monitoring_cluster} >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
