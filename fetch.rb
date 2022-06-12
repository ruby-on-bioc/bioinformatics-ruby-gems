#! /usr/bin/env ruby
# frozen_string_literal: true

require 'gems'
require 'tty-progressbar'
require 'tty-spinner'
require 'yaml'

bio_gem_names = []
spinner = TTY::Spinner.new('[:spinner] :title')
spinner.update(title: 'Search for Bio Gems')
spinner.auto_spin
i = 1

loop do
  arr = Gems.search('bio-', page: i)
  names = arr.map { _1['name'] }
  bio_gem_names += names
  i += 1
  sleep 0.5
  break unless arr.size == 30
end
spinner.success("(#{bio_gem_names.size} gems found)")

spinner.update(title: 'EXCLUDE LIST')
spinner.auto_spin
exclude_list = File.readlines('exclude_list.txt').map(&:chomp)
bio_gem_names -= exclude_list
spinner.success "#{bio_gem_names.size} gems left"

spinner.update(title: 'INCLUDE LIST')
spinner.auto_spin
include_list = File.readlines('include_list.txt').map(&:chomp)
bio_gem_names += include_list
spinner.success "#{bio_gem_names.size} gems left"

bar = TTY::ProgressBar.new(
  'Get GEM INFO [:bar]', total: bio_gem_names.size, bar_foramt: :block
)

bio_gems = []

bio_gem_names.each do |name|
  info = Gems.info(name)
  bio_gems << info
  sleep 0.5
  bar.advance
end

bar.finish

YAML.dump(bio_gems, File.open('bio-gems.yml', 'wb'))
