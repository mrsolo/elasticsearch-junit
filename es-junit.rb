#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'elasticsearch'

client = Elasticsearch::Client.new log: true
client.transport.reload_connections!
client.cluster.health
client.search q: 'test'
