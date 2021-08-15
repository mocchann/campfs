class ChangeDatatypeMessageOfContacts < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :message, :text
  end
end
