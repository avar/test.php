#!/usr/bin/env php
<?php

require 'Test.php';

plan( 1 );

if (!getenv("TEST_FAIL")) {
    diag("Set TEST_FAIL for failing tests");
    pass("phony");
} else {
    fail('This dummy test failed');
}

?>
