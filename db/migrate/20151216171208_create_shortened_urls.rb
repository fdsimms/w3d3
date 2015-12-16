class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :short_url, null: false, index: true
      t.string :long_url
      t.foreign_key :submitter_id, null: false, index: true

      t.timestamps
    end
  end
end
