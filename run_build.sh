#!/usr/bin/env bash

exec curl -X POST -H "Content-Type: application/json" --data "{ \"build\": true, \"source_name\": \"$SOURCE_BRANCH\" }" ${1}
