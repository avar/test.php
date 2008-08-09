#!/usr/bin/env php
<?php

require 'Test.php';

plan( 1 );

if (!getenv("TEST_FAIL")) {
    diag("Set TEST_FAIL for failing tests");
    pass("phony");
} else {
    cmp_ok(6, '==', 5, '== in cmp_ok()');
}

?>
