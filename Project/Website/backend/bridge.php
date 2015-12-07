<?php
/**
 * Bridge script which will output the current bridges in the database
 * output in a json format
 *
 * function examples
 * bridge.php
 * bridge.php?bid=0
 */

include_once('config.php');
include_once('dbfunctions.php');
header('Content-Type: application/json');

$conn = OrclConnect();

//bridge.php?bid=0
if (isset($_GET["bid"])) {
    $bid = $_GET["bid"];
    $sql = 'SELECT * FROM bridge WHERE BID = :v_bid';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_bid', $bid);
}
else {
    $sql = 'SELECT * FROM bridge';
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
