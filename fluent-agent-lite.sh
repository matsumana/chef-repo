#!/bin/bash

chef-solo -c .chef/solo.rb -j .chef/fluent-agent-lite.json
