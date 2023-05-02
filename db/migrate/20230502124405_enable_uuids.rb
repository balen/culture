# Use UUIDs for the ids instead of integers
# works better for SPA
class EnableUuids < ActiveRecord::Migration[7.0]
  def up
    enable_extension 'pgcrypto'
  end
end
