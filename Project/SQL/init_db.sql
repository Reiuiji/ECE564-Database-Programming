-- Database initalizer Script
-- V 0.1

PROMPT ==========================================
PROMPT |           Running Initalizer           |
PROMPT |               BridgeMon                |
PROMPT ==========================================

PROMPT Building the Database
@init_bridge.sql
@init_teds.sql
@init_sensor.sql
@init_health.sql
PROMPT Database Building Complete


PROMPT Populating with Default Data
@init_values.sql
PROMPT Populating Complete

