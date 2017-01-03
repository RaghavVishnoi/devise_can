require 'rails/generators/active_record'
class AssociationGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"	

      def copy_role_migration
      	if (behavior == :invoke && model_exists?("role")) || (behavior == :revoke && role_migration_exists?)
          migration_template "role_migration_existing.rb", "db/migrate/add_name_to_roles.rb", migration_version: migration_version
        else
          invoke "active_record:model", ["role"], migration: false unless behavior == :invoke
          migration_template "role_migration.rb", "db/migrate/create_roles.rb", migration_version: migration_version
        end
      end

      def copy_user_roles_migration
      	if (behavior == :invoke && model_exists?("user_role")) || (behavior == :revoke && user_role_migration_exists?)
          migration_template "user_role_migration_existing.rb", "db/migrate/add_user_roles_association_to_user_roles.rb", migration_version: migration_version
        else
          invoke "active_record:model", ["user_role"], migration: false unless behavior == :invoke
          migration_template "user_role_migration.rb", "db/migrate/create_user_roles.rb", migration_version: migration_version
        end
      end

     

private
      def model_exists?(model_name)
        File.exist?(File.join(destination_root, model_path(model_name)))
      end

      def role_migration_exists?
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_name_to_roles.rb$/).first
      end

      def user_role_migration_exists?
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_user_roles_association_to_user_roles.rb$/).first
      end

      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

      def model_path(model_name)
        @model_path ||= File.join("app", "models", "#{model_name}.rb")
      end

      def migration_version
       if rails5?
         "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
       end
      end

      def rails5?
        Rails.version.start_with? '5'
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
