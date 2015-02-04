#!/bin/bash

# Requires that the user have bundler installed
bundle install
rake start_server --trace
