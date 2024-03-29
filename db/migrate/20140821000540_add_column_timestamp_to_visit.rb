class AddColumnTimestampToVisit < ActiveRecord::Migration
  def change
    add_column(:visits, :created_at, :datetime)
    add_column(:visits, :updated_at, :datetime)
    add_column(:users, :created_at, :datetime)
    add_column(:users, :updated_at, :datetime)
    add_column(:shortened_urls, :created_at, :datetime)
    add_column(:shortened_urls, :updated_at, :datetime)
  end
end
