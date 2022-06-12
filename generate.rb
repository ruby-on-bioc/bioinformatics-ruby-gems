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

warn 'Fields'
bio_gems.each do |r|
  puts erb.result(binding)
end
