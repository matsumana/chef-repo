#!/bin/bash

chef-solo -c .chef/solo.rb -j .chef/growthforecast-client.json
