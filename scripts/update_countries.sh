#!/bin/bash

echo Download countries
wget https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip -O /ressources/ne_10m_admin_0_countries.zip

echo Unzipping archive
unzip /ressources/ne_10m_admin_0_countries.zip -d /ressources

echo Converting shp to sql
shp2pgsql -d -s 4326 -I -D /ressources/ne_10m_admin_0_countries.shp countries > /ressources/countries.sql

echo Writing sql to database
psql postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@timescaledb:5432/${POSTGRES_DB} -f /ressources/countries.sql

echo Finished country import