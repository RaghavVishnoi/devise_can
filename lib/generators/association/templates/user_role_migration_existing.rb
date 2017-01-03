class AddUserRolesAssociationToUserRoles < ActiveRecord::Migration
  def self.up
    change_column :user_roles,:user_id,:integer,index: true
    change_column :user_roles,:role_id,:integer,index: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end