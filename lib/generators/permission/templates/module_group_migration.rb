class CreateModuleGroup < ActiveRecord::Migration
  def change
    create_table :module_groups do |t|
<%= module_group_migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

  end
end
