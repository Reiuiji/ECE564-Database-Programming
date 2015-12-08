<?php
/**
 * Database Functions
 * Collection of various functions to handle various routines with the database
 *
 */

function OrclConnect() {
    $conn = oci_connect(DB_USER,DB_PASSWORD,DB_CONNECTION);
    if(DEBUG_MODE) {
        if(!$conn) {
            echo("\n<!--Debug: Connection Failed!-->\n");
            $e = oci_error();
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        } else{
            echo("\n<!--Debug: Connection Established!-->\n");
        }
    }
    return $conn;
}

function GetAuthToken($conn, $sid) {
    $sql = 'SELECT A.KEY FROM ACCESS_TOKEN A WHERE SENSOR_ID = :v_sid';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_sid', $sid);
    oci_execute($stid);
    oci_fetch_all($stid, $res);
    return $res['KEY'][0];
}

function GenerateToken($conn, $sid) {
    $Token = md5(mcrypt_create_iv(22, MCRYPT_DEV_URANDOM));
    $sql = 'BEGIN INSERT_TOKEN(:v_sid,:v_token); end;';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_sid', $sid);
    oci_bind_by_name($stid, ':v_token', $Token);
    $r = oci_execute($stid);
    if (!$r) {
        $e = oci_error($stid);
        return false;
    }
    oci_free_statement($stid);
    return $Token;
}

function InsertData($conn, $sid, $val) {
    $sql = 'BEGIN INSERT_DATA(:v_sid,:v_val); end;';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_sid', $sid);
    oci_bind_by_name($stid, ':v_val', $val);
    $r = oci_execute($stid);
    if (!$r) {
        //$e = oci_error($stid);
        return false;
    }
    oci_free_statement($stid);
    return true;
}

function UserLogin($conn, $username, $password) {
    $hash = retrieveHash($conn,$username);
    if (password_verify($password, $hash) ) {
        $fortunecookie = GenerateUserToken($conn,$username);
        setcookie('login', $username, $fortunecookie);
        return true;
    }
    return false;
}

function retrieveHash($conn,$username) {
    $sql = 'SELECT U.PASSWORD FROM User_Tbl U WHERE Username = :v_user';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':v_user', $username);
    oci_execute($stid);
    oci_fetch_all($stid, $res);
    return $res['PASSWORD'][0];
}

function CreateUser($conn, $username, $password, $email) {
    $pass = GenPass($username, $password);
    $stid = oci_parse($conn, 'INSERT INTO User_Tbl VALUES (:v_user, :v_email :v_pass)');
    oci_bind_by_name($stid, ":v_user", $username);
    oci_bind_by_name($stid, ":v_email", $email);
    oci_bind_by_name($stid, ":v_pass", $pass);
    $r = oci_execute($stid);
    if (!$r) {
        $e = oci_error($stid);
        return htmlentities($e['message']);
    }
    return true;
}

function GenPass($username, $password) {
    $options = [
        'cost' => 12,
        'salt' => mcrypt_create_iv(22, MCRYPT_DEV_URANDOM)
    ];
    $hash = password_hash($password, PASSWORD_DEFAULT, $options);
    return $hash;
}

function UpdatePass($conn, $username, $password) {
    $hash = GenPass($username, $password);
    $sql = 'UPDATE User_Tbl SET Password=:v_pass WHERE Username = :v_user';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ":v_user", $username);
    oci_bind_by_name($stid, ":v_pass", $hash);
    $r = oci_execute($stid);
    if (!$r) {
        $e = oci_error($stid);
        return htmlentities($e['message']);
    }
    return true;
}
