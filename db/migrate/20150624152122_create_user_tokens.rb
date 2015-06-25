class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.belongs_to :user, index: true, null: false
      t.string :token

      t.timestamps
    end
  end
end
