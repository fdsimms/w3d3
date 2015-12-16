class AddSubmitterIdToShortenedUrls < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :submitter_id, :integer, index: true
  end
end
