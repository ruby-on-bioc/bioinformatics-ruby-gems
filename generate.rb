# frozen_string_literal: true

require 'gems'
require 'erb'

bio_gems = []
i = 1

loop do
  arr = Gems.search('bio-', page: i)
  bio_gems.concat(arr)
  i += 1
  sleep 0.5
  break unless arr.size == 30
end

# EXCLUDE LIST
exclude_list = File.readlines('exclude_list.txt').map(&:chomp)

bio_gems.filter! do |r|
  !exclude_list.include? r['name']
end

# TITLE
puts '# Bio Gems'
puts

erb = ERB.new(File.read('table.erb'), trim_mode: '-')

# Table 
bio_gems.each do |r|
  puts erb.result(binding)
end
