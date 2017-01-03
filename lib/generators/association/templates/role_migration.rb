class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
<%= role_migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

  end
end
