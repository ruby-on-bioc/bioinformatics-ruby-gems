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

# BLACKLIST

blacklist = File.readlines('blacklist.txt').map(&:chomp)

bio_gems.filter! do |r|
  !blacklist.include? r['name']
end

# TITLE
puts '# Bio Gems'
puts

erb = ERB.new(File.read('gem.erb'), trim_mode: '-')

# GEMS
bio_gems.each do |r|
  puts erb.result(binding)
end
