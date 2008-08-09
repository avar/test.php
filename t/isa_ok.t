#!/usr/bin/env php
<?php

require 'Test.php';

plan(3);

class SomeClass {
	function __construct() { }
}

class SomeSubClass extends SomeClass {
}

$obj = new SomeClass;
isa_ok($obj, 'SomeClass');

$subobj = new SomeSubClass;
isa_ok($subobj, 'SomeClass');
isa_ok($subobj, 'SomeSubClass');

?>
