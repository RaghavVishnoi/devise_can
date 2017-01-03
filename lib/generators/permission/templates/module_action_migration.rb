class CreateModuleAction < ActiveRecord::Migration
  def change
    create_table :module_actions do |t|
<%= module_action_migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

  end
end
