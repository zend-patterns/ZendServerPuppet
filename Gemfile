source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :unit_tests do
  gem 'json',                                                      :require => false
  gem 'puppet-lint'                                                :require => false
  gem 'puppetlabs_spec_helper',                                    :require => false
  gem 'rspec-puppet-facts',                                        :require => false
  gem 'rubocop',                                                   :require => false if RUBY_VERSION =~ /^2\./
end

group :development do
  # gem 'guard-rake',       :require => false
  gem 'librarian-puppet', :require => false
  gem 'simplecov',        :require => false
end

group :system_tests do
  if RUBY_VERSION < '2.2.5'
    gem 'beaker', '~> 2.0', :require => false
  else
    gem 'beaker-rspec', :require => false
  end
  gem 'serverspec', :require => false
  # gem 'vagrant-wrapper', :require => false
end

# json_pure 2.0.2 added a requirement on ruby >= 2. We pin to json_pure 2.0.1
# if using ruby 1.x
gem 'json_pure', '<= 2.0.1', :require => false if RUBY_VERSION =~ /^1\./

if (facterversion = ENV['FACTER_GEM_VERSION'])
  gem 'facter', facterversion, :require => false
end

if (puppetversion = ENV['PUPPET_GEM_VERSION'])
  gem 'puppet', puppetversion, :require => false
end

# vim:ft=ruby
