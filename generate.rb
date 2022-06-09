require 'gems'

bio_gems = []
i = 1

begin
  arr = Gems.search('bio-', page: i)
  bio_gems.concat(arr)
  i += 1
  sleep 0.5
end while arr.size == 30

# BLACKLIST

blacklist = File.readlines('blacklist.txt').map(&:chomp)

bio_gems.filter do |r|
  false if blacklist.include? r['name']
end

# TITLE
puts '# Bio Gems'
puts

# GEMS
bio_gems.each do |r|
  puts "## #{r['name']}"
  puts
  puts r['info'] && r.delete('info')
  puts
  puts '|key|value|'
  puts '|---|-----|'
  r.each do |k, v|
    puts "|#{k}|#{v}|" if v
  end
  puts
end
