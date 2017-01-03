class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
<%= user_role_migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

  end
end
