class CreateModulePermission < ActiveRecord::Migration
  def change
    create_table :module_permissions do |t|
<%= module_permission_migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

  end
end
