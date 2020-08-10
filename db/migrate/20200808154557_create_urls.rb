class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.string :sanitize_url
      t.integer :clicks
      t.datetime :expires_at

      t.timestamps
    end
  end
end
