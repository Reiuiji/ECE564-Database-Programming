-- Database initalizer Script

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

PROMPT Setting UP Securing Access Tbls
@init_security.sql
PROMPT Secure Setup Complete

PROMPT Populating with Default Data
@init_values.sql
PROMPT Populating Complete

-- Commit the work
COMMIT WORK;