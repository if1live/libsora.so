#!/bin/bash

./cli/libsora.so
if [ $? != 0 ]; then
    exit -1
fi

bash ./bin/copy_static.sh

cd hugo
hugo -t sora --destination=output
status=$?
cd -
exit $status
