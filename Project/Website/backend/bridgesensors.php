<?php
/**
 * Bridge script which will output the sensors on a specific bridge
 * output in a json format
 *
 * function examples
 * bridgesensors.php
 * bridgesensors.php?bid=0
 * bridgesensors.php?bid=0&sid=0
 */

include_once('config.php');
include_once('dbfunctions.php');
//bridge.php?bid=0&sid=1
if (isset($_GET["bid"])) {
    header('Content-Type: application/json');
    $conn = OrclConnect();
    $bid = $_GET["bid"];

    if (isset($_GET["sid"])) {
        $sid = $_GET["sid"];
        $sql = 'SELECT DU.Dataentry, DU.Val FROM Data_Update DU JOIN Sensor_Tbl ST ON ST.Sensor_ID = DU.Sensor_ID WHERE ST.BRIDGE_ID = :v_bid and DU.Sensor_ID = :v_sid';
        $stid = oci_parse($conn, $sql);
        oci_bind_by_name($stid, ':v_sid', $sid);
        oci_bind_by_name($stid, ':v_bid', $bid);
    } else {
        $sql = 'SELECT DU.Sensor_ID, DU.Dataentry, DU.Val FROM Data_Update DU JOIN Sensor_Tbl ST ON ST.Sensor_ID = DU.Sensor_ID WHERE ST.BRIDGE_ID = :v_bid';
        $stid = oci_parse($conn, $sql);
        oci_bind_by_name($stid, ':v_bid', $bid);
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

}
