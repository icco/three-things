$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "three-things"

require "minitest/autorun"
require "rack/test"
require "statsd"
require "vcr"
