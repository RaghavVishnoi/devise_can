require 'rails/generators/active_record'
class PermissionGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"	


  def copy_module_group_migration
  	if (behavior == :invoke && model_exists?("module_group")) || (behavior == :revoke && role_migration_exists?)
      migration_template "module_group_migration_existing.rb", "db/migrate/add_name_to_module_group.rb", migration_version: migration_version
    else
      migration_template "module_group_migration.rb", "db/migrate/create_module_group.rb", migration_version: migration_version
    end
  end

  def copy_module_action_migration
  	if (behavior == :invoke && model_exists?("module_action")) || (behavior == :revoke && role_migration_exists?)
      migration_template "module_action_migration_existing.rb", "db/migrate/add_name_to_module_action.rb", migration_version: migration_version
    else
      migration_template "module_action_migration.rb", "db/migrate/create_module_action.rb", migration_version: migration_version
    end
  end

  def copy_module_permission_migration
  	if (behavior == :invoke && model_exists?("module_permission")) || (behavior == :revoke && role_migration_exists?)
      migration_template "module_permission_migration_existing.rb", "db/migrate/add_group_action_to_module_permission.rb", migration_version: migration_version
    else
      migration_template "module_permission_migration.rb", "db/migrate/create_module_permission.rb", migration_version: migration_version
    end
  end

  def copy_module_action_model
    copy_file "module_action_model.rb","app/models/module_action.rb"
  end

  def copy_module_group_model
    copy_file "module_group_model.rb","app/models/module_group.rb"
  end

  def copy_module_permission_model
    copy_file "module_permission_model.rb","app/models/module_permission.rb"
  end

  def copy_ability
  	copy_file "ability_model.rb","app/models/ability.rb"
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
        File.join("app", "models", "#{model_name}.rb")
      end

      def migration_version
       if rails5?
         "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
       end
      end

      def rails5?
        Rails.version.start_with? '5'
      end

      def module_group_migration_data
<<RUBY
      		t.string :name

RUBY
      end

      def module_action_migration_data
<<RUBY
      		t.string :name

RUBY
      end

       def module_permission_migration_data
<<RUBY
			t.belongs_to :module_group
			t.belongs_to :module_action
			t.belongs_to :role	
RUBY
       end


end