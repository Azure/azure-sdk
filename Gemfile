source "https://rubygems.org"

# See https://pages.github.com/versions/
gem "github-pages", ">= 231", group: [:jekyll_plugins]

# Force certain dependencies that may be upgraded to an unsupported version for Ruby 2.7 otherwise.
gem "nokogiri", "~> 1.16.5"
gem "webrick", "~> 1.8"
gem 'csv', '~> 3.3'
gem 'faraday-retry', '~> 2.2', '>= 2.2.1'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.0" if Gem.win_platform?