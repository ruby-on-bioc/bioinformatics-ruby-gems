require "gems"

results = []
i = 1

begin
  arr = Gems.search("bio-", page: i)
  results.concat(arr)
  i += 1
  sleep 0.5
end while arr.size == 30

puts "# Bio Gems"
puts

results.each do |r|
  puts "## #{r["name"]}"
  puts
  puts r["info"] && r.delete("info")
  puts
  puts "|key|value|"
  puts "|---|-----|"
  r.each do |k,v|
    puts "|#{k}|#{v}|" if v
  end
  puts
end
