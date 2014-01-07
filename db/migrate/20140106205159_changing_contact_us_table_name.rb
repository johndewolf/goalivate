class ChangingContactUsTableName < ActiveRecord::Migration
  def up
    rename_table :contact_us, :contact_inquiries
  end

  def down
    rename_table :contact_inquiries, :contact_us
  end
end
