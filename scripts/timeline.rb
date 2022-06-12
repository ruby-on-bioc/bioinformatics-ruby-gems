require 'gems'
require 'date'
require 'csv'
require 'tty-spinner'

a = YAML.load(
  File.read(File.expand_path('../bio-gems.yml', __dir__))
)

dates = []

spinner = TTY::Spinner.new('[:spinner] :title')
spinner.update(title: 'Fetch Gem info')
spinner.auto_spin

a.map do |h|
  n =  h['name']
  r = Gems.versions(n)
  r.each do |g|
    dt = DateTime.parse(g["created_at"])
    dates << [n, dt.day, dt.month, dt.year]
  end
end

spinner.success

CSV.open(File.expand_path("timeline.csv", __dir__), "wb") do |csv|
  csv << ["gems", "day", "month", "year"]
  dates.each do |d|
    csv << d
  end
end

