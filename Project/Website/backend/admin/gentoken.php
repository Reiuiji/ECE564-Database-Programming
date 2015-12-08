<?php
/**
 * Generate Token Utility
 * Will provide a new token for any sensor id
 * ADMIN ONLY
 *
 * Generate Token Utility
 * gentoken.php?sid=0
 */

if(isset($_GET['sid'])) {
    include_once('../config.php');
    include_once('../dbfunctions.php');
    $sid = $_GET['sid'];
    $conn = OrclConnect();
    $token = GenerateToken($conn, $sid);
    if ($token == false) {
        echo "Gen Token Failed";
    } else {
        echo "Sensor ID : ", $sid , "<br>\n";
        echo "Token     : ", $token, "<br>";
    }
    oci_close($conn);
}
