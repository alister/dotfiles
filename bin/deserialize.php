#!/usr/bin/env php
<?php
 
// Enable error reporting
error_reporting(E_ALL | E_STRICT);
 
// Get command line arguments
$userArgs = $argv;
 
// Check that an argument was provided
if ( !isset( $userArgs[1] ) ) {
    echo "\nNo path submitted: a path to a serialized PHP data file is required'\n\n";
    die();
} elseif ( '/' == substr( $userArgs[1], 0, 1 ) ) {
    // The supplied path is absolute
    $serializedPath = $userArgs[1];
} else {
    // If the supplied path is relative
    echo "\nRelative path supplied but not supported, please provide an absolute path\n\n";
    die();
}
 
// Get the serialised data for processing
$serialized = file_get_contents( $serializedPath );
 
// Unserialize the data
$unserialized = unserialize( $serialized );
 
// Print the data array in readable form
print_r( $unserialized );
