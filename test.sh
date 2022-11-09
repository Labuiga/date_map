#!/bin/bash


dps=$(docker ps)
if grep -q "date_map_mongo" <<< "$dps"; then
  echo "$dps"
fi