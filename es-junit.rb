#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'elasticsearch'
require 'processor'



client = Elasticsearch::Client.new log: true
client.transport.reload_connections!
client.cluster.health
client.search q: 'test'

puts client.methods.sort
client.index  index: 'myindex', type: 'mytype', id: 1, body: { title: 'Test' }
client.search index: 'myindex', body: { query: { match: { title: 'test' } } }

require 'jbuilder'

query = Jbuilder.encode do |json|
  json.query do
    json.match do
      json.title do
        json.query    'test'
      end
    end
  end
end

client.search index: 'myindex', body: query

require 'hashie'

response = client.search index: 'myindex',
                         body: {
                           query: { match: { title: 'test' } },
                           facets: { tags: { terms: { field: 'tags' } } }
                         }

mash = Hashie::Mash.new response

puts mash.hits.hits.first._source.title
# => 'Test'

require 'yaml'
puts YAML.dump(mash.facets.tags.terms.first)
# => #<Hashie::Mash count=3 term="z">

mash = Hashie::Mash.new client.index index: 'checkme', ttl: '1d', type: 'testme',  body: { title: 'Test' }
puts YAML.dump mash

#read from directory

require 'find'

Find.find(File.join(ENV["HOME"], 'elasticsearch-junit', 'test')) do |path|
  #skip directory
  unless(File.directory?(path))
    #check to see if has '.xml' extension
    if(File.extname(path) == '.xml')
      puts File.basename(path)
    end
  end
end
