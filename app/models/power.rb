# frozen_string_literal: true

class Power
  include Consul::Power

  def initialize(user, access = 'app')
    @current_user = user
    @access       = access
  end

  # Generate powers for all tables and by default prevent them all from access
  ActiveRecord::Base.connection.tables.map(&:to_sym) - %i[schema_migrations ar_internal_metadata].each do |model|
    power model do
      false
    end
  end

  # allow evryone to user sessions api
  power :sessions do
    true
  end
end
