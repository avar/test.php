#!/usr/bin/env php
<?php

require 'Test.php';

$schedule = array(
    array(
        'name'      => 'Simple number',
        'expected'  => 1,
        'got'       => 1,
        'output'    => null
    ),
    array(
        'name'      => 'Matching array',
        'expected'  => array(1, 2, 3),
        'got'       => array(1, 2, 3),
        'output'    => null
    ),
    array(
        'name'      => 'Matching hash',
        'expected'  => array('foo' => 'bar', '123' => array(1, 2, 3)),
        'got'       => array('foo' => 'bar', '123' => array(1, 2, 3)),
        'output'    => null
    ),
    array(
        'name'      => 'Different types',
        'expected'  => 123,
        'got'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '',
            'got'       => 'array(1, 2, 3)',
            'epath'     => '',
            'expected'  => 123
        )
    ),
    array(
        'name'      => 'Different strings',
        'expected'  => 'this',
        'got'       => 'that',
        'output'    => array(
            'gpath'     => '',
            'got'       => "'that'",
            'epath'     => '',
            'expected'  => "'this'"
        )
    ),
    array(
        'name'      => 'Different arrays',
        'expected'  => array(1, 2, 4),
        'got'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '[2]',
            'got'       => 3,
            'epath'     => '[2]',
            'expected'  => 4
        )
    ),
    array(
        'name'      => 'Deeper arrays',
        'expected'  => array(1, 2, array(3, 4)),
        'got'       => array(1, 2, array(3, 5)),
        'output'    => array(
            'gpath'     => '[2][1]',
            'got'       => 5,
            'epath'     => '[2][1]',
            'expected'  => 4
        )
    ),
    array(
        'name'      => 'Larger arrays',
        'expected'  => array(1, 2, 3, 4),
        'got'       => 1234,
        'output'    => array(
            'gpath'     => '',
            'got'       => 1234,
            'epath'     => '',
            'expected'  => 'array(1, 2, 3, ... 1 more element ...)'
        )
    ),
    array(
        'name'      => 'Larger arrays 2',
        'expected'  => array(1, 2, 3, 4, 5),
        'got'       => 12345,
        'output'    => array(
            'gpath'     => '',
            'got'       => 12345,
            'epath'     => '',
            'expected'  => 'array(1, 2, 3, ... 2 more elements ...)'
        )
    ),
    array(
        'name'      => 'Missing 1',
        'expected'  => array(1, 2, 3),
        'got'       => array(1, 2),
        'output'    => array(
            'gpath'     => 'missing',
            'got'       => 'nothing',
            'epath'     => '[2]',
            'expected'  => 3
        )
    ),
    array(
        'name'      => 'Missing 2',
        'expected'  => array(1, 2),
        'got'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '[2]',
            'got'       => 3,
            'epath'     => 'missing',
            'expected'  => 'nothing'
        )
    ),
    array(
        'name'      => 'Different hash',
         'expected'  => array('foo' => 'bar', '123' => array(
             'one' => 1, 'two' => 2, 'three' => 3
         )),
        'got'       => array('foo' => 'bar', '123' => 123),
        'output'    => array(
            'gpath'     => "[123]",
            'got'       => 123,
            'epath'     => "[123]",
            'expected'  => "array('one' => 1, 'two' => 2, 'three' => 3)"
        )
    ),
    array(
        'name'      => 'Hash missing 1',
        'expected'  => array('foo' => 'bar', '123' => 123),
        'got'       => array('foo' => 'bar'),
        'output'    => array(
            'gpath'     => 'missing',
            'got'       => 'nothing',
            'epath'     => "[123]",
            'expected'  => 123
        )
    ),
    array(
        'name'      => 'Hash missing 2',
        'expected'  => array('foo' => 'bar'),
        'got'       => array('foo' => 'bar', '123' => 123),
        'output'    => array(
            'gpath'     => "[123]",
            'got'       => 123,
            'epath'     => 'missing',
            'expected'  => 'nothing'
        )
    ),
    array(
        'name'      => 'Hash ordering',
        'expected'  => array('foo' => 'bar', 'bar' => 'foo'),
        'got'       => array('bar' => 'foo', 'foo' => 'bar'),
        'output'    => array(
            'gpath'     => "['bar']",
            'got'       => "'foo'",
            'epath'     => "['foo']",
            'expected'  => "'bar'"
        )
    ),
    array(
        'name'      => 'Deep array',
        'expected'  => array(1, 2, 3),
        'got'       => array(1, 2, 3),
        'output'    => null
    ),
);

plan( count($schedule) * 2 );

foreach ($schedule as $test) {
    $name = $test['name'];
    $diff = _cmp_deeply($test['got'], $test['expected']);

    # Simple test - since is_deeply depends on _cmp_deeply
    is(serialize($diff), serialize($test['output']), "$name: output OK");
    # Now do it again with is_deeply
    is_deeply($diff, $test['output'], "$name output deeply OK");
}

?>
