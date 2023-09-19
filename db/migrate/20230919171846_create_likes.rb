# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true  # changed from :author to :user
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
