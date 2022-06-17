#! /usr/bin/env ruby
# frozen_string_literal: true

require 'erb'
require 'date'
require 'yaml'

bio_gems = YAML.load(File.open('bio-gems.yml', 'rb'))

puts '## The List of Bio Gems'
puts
puts '* https://github.com/ruby-on-bioc/bio-gems'
puts

erb = ERB.new(File.read('field.erb'), trim_mode: '-')

def code_size_badge(r)
  if l = r['homepage_uri']
    if l.match(%r{github.com/(.*)/(.*)})
      name = Regexp.last_match(1)
      repo = Regexp.last_match(2)
      "https://sloc.xyz/github/#{name}/#{repo}"
    end
  elsif l = r['source_code_uri']
    if l.match(%r{github.com/(.*)/(.*)})
      name = Regexp.last_match(1)
      repo = Regexp.last_match(2)
      "https://sloc.xyz/github/#{name}/#{repo}"
    end
  end
end

warn 'Fields'
bio_gems.each do |r|
  puts erb.result(binding)
end
