#!/bin/bash

chef-solo -c .chef/solo.rb -j .chef/td-agent.json
