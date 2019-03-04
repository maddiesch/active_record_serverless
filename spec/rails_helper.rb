ENV['RAILS_ENV'] = 'test'

require 'rails/all'
require 'rspec/rails'

require_relative 'spec_helper'
require_relative 'dummy/config/environment'
require_relative 'dummy/db/schema'

Dir.glob(Rails.root.join('spec', '..', '..', 'support', '**', '*.rb')).each { |f| require f }

RSpec.configure do |config|
end
