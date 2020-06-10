class CreateMentionableMentions < ActiveRecord::Migration[6.0]
  def change
    create_table :mentionable_mentions do |t|
      t.string :source, null: false
      t.string :target, null: false

      t.timestamps
    end
  end
end
