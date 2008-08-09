#!/usr/bin/env php
<?php

require 'Test.php';

plan(8);

ok(1);
ok(2);

todo_start("oh noes todo");
ok(0);
is("foo", "bar");
{
    todo_start("oh noes another todo");
    ok(!!0);
    is("eek", "ook");
    todo_end();
}
todo_end();

ok(3);
ok(4);

?>
