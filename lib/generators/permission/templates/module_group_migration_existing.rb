class AddNameToModuleGroup < ActiveRecord::Migration
  def self.up
    change_column :module_groups,:name,:string
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end