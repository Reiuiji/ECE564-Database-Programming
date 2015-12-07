<?php
/**
 * Configuration File for BridgeMon
 *
 * This file has the following configurations:
 *
 *  Oracle SQL Connection info
 *  Debug Mode
 *
 */

 // ** Oracle SQL settings ********** //

 /** Oracle SQL Connection Info */
 define('DB_CONNECTION', 'localhost/orcl');

 /** Oracle SQL Database Username */
 define('DB_USER', 'USER');

 /** Oracle SQL Database Password */
 define('DB_PASSWORD', 'PASSWORD');


 // ** Debugging Settings ********** //

 /** Set Debug mode */
 define('DEBUG_MODE', true);

 /* That's all you need to edit ... stop editing beyond this point! */

 /** Absolute path for the site */
 if ( !defined('ABS_PATH') )
     define('ABS_PATH', dirname(__FILE__) . '/');
