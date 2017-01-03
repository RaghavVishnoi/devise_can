require 'rails/generators/active_record'
require 'generators/common'
class AssociationGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"	

      def copy_role_migration
      	if (behavior == :invoke && model_exists?("role")) || (behavior == :revoke && role_migration_exists?)
          migration_template "role_migration_existing.rb", "db/migrate/add_name_to_roles.rb", migration_version: migration_version
        else
          migration_template "role_migration.rb", "db/migrate/create_roles.rb", migration_version: migration_version
        end
      end

      def copy_user_roles_migration
      	if (behavior == :invoke && model_exists?("user_role")) || (behavior == :revoke && user_role_migration_exists?)
          migration_template "user_role_migration_existing.rb", "db/migrate/add_user_roles_association_to_user_roles.rb", migration_version: migration_version
        else
          migration_template "user_role_migration.rb", "db/migrate/create_user_roles.rb", migration_version: migration_version
        end
      end

      def copy_role_model
        if model_exists?("role")
          copy_file "role_model_existing.rb","app/models/role.rb"
        else
          copy_file "role_model.rb","app/models/role.rb"
        end
      end

      def copy_user_role_model
        if model_exists?("user_role")
          copy_file "user_role_model_existing.rb","app/models/user_role.rb"
        else
          copy_file "user_role_model.rb","app/models/user_role.rb"
        end
      end
     



      def role_migration_data
<<RUBY
      		t.string :name

RUBY
      end

       def user_role_migration_data
<<RUBY
			t.belongs_to :user
			t.belongs_to :role	
RUBY
       end



end
