require 'gr/plot'

data = Marshal.load(
  File.open(File.expand_path('../bio_gems.marshal', __dir__), 'rb')
)

year = data.map { |r| r['version_created_at'].split('-')[0].to_i }

x, y = year.tally.sort_by { |k, _v| k }.transpose

GR.barplot(x, y, title: 'Bio gems last update date', xlabel: 'Year', ylabel: 'Gems')
GR.savefig('bio_gems_year.png')
