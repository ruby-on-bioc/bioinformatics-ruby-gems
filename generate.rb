require "gems"
require "json"

result = []
i = 1

begin
  arr = Gems.search("bio-", page: i)
  result.concat(arr)
  i += 1
  sleep 0.5
end while arr.size == 30

json = JSON.generate(result)
JSON.parse(json) # validate

puts json
