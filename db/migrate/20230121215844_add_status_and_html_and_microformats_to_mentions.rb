class AddStatusAndHtmlAndMicroformatsToMentions < ActiveRecord::Migration[7.0]
  def change
    add_column :mentionable_mentions, :status, :string
    add_column :mentionable_mentions, :html, :text
  end
end
