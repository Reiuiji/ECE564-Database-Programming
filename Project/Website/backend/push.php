<?php
/**
 * Sensor data push script
 * Handles all the incoming data from various sensors
 *
 * function examples
 * push.php?sid=0&auth=
 */
if(isset($_GET['sid']) && isset($_GET['auth']) && isset($_GET['val']))
{
    include_once('config.php');
    include_once('dbfunctions.php');
    $conn = OrclConnect();

    $sid  = $_GET['sid'];
    $auth = $_GET['auth'];
    $val = $_GET['val'];

    $token = GetAuthToken($conn,$sid);

    if ($auth == $token) {
        echo "Auth Succeed: ";
        echo InsertData($conn, $sid, $val);
    } else {
        echo "Auth Failed";
    }

}
