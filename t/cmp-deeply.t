#!/usr/bin/env php
<?php

require 'Test.php';

$schedule = array(
    array(
        'name'      => 'Simple number',
        'want'  => 1,
        'have'       => 1,
        'output'    => null
    ),
    array(
        'name'      => 'Matching array',
        'want'  => array(1, 2, 3),
        'have'       => array(1, 2, 3),
        'output'    => null
    ),
    array(
        'name'      => 'Matching hash',
        'want'  => array('foo' => 'bar', '123' => array(1, 2, 3)),
        'have'       => array('foo' => 'bar', '123' => array(1, 2, 3)),
        'output'    => null
    ),
    array(
        'name'      => 'Different types',
        'want'  => 123,
        'have'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '',
            'have'       => 'array(1, 2, 3)',
            'epath'     => '',
            'want'  => 123
        )
    ),
    array(
        'name'      => 'Different strings',
        'want'  => 'this',
        'have'       => 'that',
        'output'    => array(
            'gpath'     => '',
            'have'       => "'that'",
            'epath'     => '',
            'want'  => "'this'"
        )
    ),
    array(
        'name'      => 'Different arrays',
        'want'  => array(1, 2, 4),
        'have'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '[2]',
            'have'       => 3,
            'epath'     => '[2]',
            'want'  => 4
        )
    ),
    array(
        'name'      => 'Deeper arrays',
        'want'  => array(1, 2, array(3, 4)),
        'have'       => array(1, 2, array(3, 5)),
        'output'    => array(
            'gpath'     => '[2][1]',
            'have'       => 5,
            'epath'     => '[2][1]',
            'want'  => 4
        )
    ),
    array(
        'name'      => 'Larger arrays',
        'want'  => array(1, 2, 3, 4),
        'have'       => 1234,
        'output'    => array(
            'gpath'     => '',
            'have'       => 1234,
            'epath'     => '',
            'want'  => 'array(1, 2, 3, ... 1 more element ...)'
        )
    ),
    array(
        'name'      => 'Larger arrays 2',
        'want'  => array(1, 2, 3, 4, 5),
        'have'       => 12345,
        'output'    => array(
            'gpath'     => '',
            'have'       => 12345,
            'epath'     => '',
            'want'  => 'array(1, 2, 3, ... 2 more elements ...)'
        )
    ),
    array(
        'name'      => 'Missing 1',
        'want'  => array(1, 2, 3),
        'have'       => array(1, 2),
        'output'    => array(
            'gpath'     => 'missing',
            'have'       => 'nothing',
            'epath'     => '[2]',
            'want'  => 3
        )
    ),
    array(
        'name'      => 'Missing 2',
        'want'  => array(1, 2),
        'have'       => array(1, 2, 3),
        'output'    => array(
            'gpath'     => '[2]',
            'have'       => 3,
            'epath'     => 'missing',
            'want'  => 'nothing'
        )
    ),
    array(
        'name'      => 'Different hash',
         'want'  => array('foo' => 'bar', '123' => array(
             'one' => 1, 'two' => 2, 'three' => 3
         )),
        'have'       => array('foo' => 'bar', '123' => 123),
        'output'    => array(
            'gpath'     => "[123]",
            'have'       => 123,
            'epath'     => "[123]",
            'want'  => "array('one' => 1, 'two' => 2, 'three' => 3)"
        )
    ),
    array(
        'name'      => 'Hash missing 1',
        'want'  => array('foo' => 'bar', '123' => 123),
        'have'       => array('foo' => 'bar'),
        'output'    => array(
            'gpath'     => 'missing',
            'have'       => 'nothing',
            'epath'     => "[123]",
            'want'  => 123
        )
    ),
    array(
        'name'      => 'Hash missing 2',
        'want'  => array('foo' => 'bar'),
        'have'       => array('foo' => 'bar', '123' => 123),
        'output'    => array(
            'gpath'     => "[123]",
            'have'       => 123,
            'epath'     => 'missing',
            'want'  => 'nothing'
        )
    ),
    array(
        'name'      => 'Hash ordering',
        'want'  => array('foo' => 'bar', 'bar' => 'foo'),
        'have'       => array('bar' => 'foo', 'foo' => 'bar'),
        'output'    => array(
            'gpath'     => "['bar']",
            'have'       => "'foo'",
            'epath'     => "['foo']",
            'want'  => "'bar'"
        )
    ),
    array(
        'name'      => 'Deep array',
        'want'  => array(1, 2, 3),
        'have'       => array(1, 2, 3),
        'output'    => null
    ),
);

plan( count($schedule) * 2 );

foreach ($schedule as $test) {
    $name = $test['name'];
    $diff = _cmp_deeply($test['have'], $test['want']);

    # Simple test - since is_deeply depends on _cmp_deeply
    is(serialize($diff), serialize($test['output']), "$name: output OK");
    # Now do it again with is_deeply
    is_deeply($diff, $test['output'], "$name output deeply OK");
}

?>
