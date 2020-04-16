class AddTrigramExtension < ActiveRecord::Migration[6.0]
  def up
    enable_extension "pg_trgm"
    enable_extension 'fuzzystrmatch'
  end

  def down
    disable_extension "pg_trgm"
    disable_extension 'fuzzystrmatch'
  end
end
