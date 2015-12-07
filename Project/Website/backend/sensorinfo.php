<?php
/**
 * Sensor Info Script will provide the variaous information of the sensors
 * in the database or connected to a specific bridge
 *
 * function examples
 * sensorinfo.php
 * sensorinfo.php?bid=0
 */

include_once('config.php');
include_once('dbfunctions.php');
header('Content-Type: application/json');

$conn = OrclConnect();

if(isset($_GET['bid']))
{
    $bid = $_GET['bid'];
    $sql = 'SELECT * FROM Sensor WHERE Sensor.Bridge_ID = :v_bid';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_bid', $bid);
} else {
    $sql = 'SELECT * FROM Sensor';
    $stid = oci_parse($conn, $sql);
}
oci_execute($stid);

$rows = array();
while($r = oci_fetch_assoc($stid)) {
    $rows[] = $r;
}
$results = (json_encode($rows, JSON_PRETTY_PRINT));

echo $results;

oci_free_statement($stid);
oci_close($conn);

