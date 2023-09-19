# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true  # changed from :author to :user
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
