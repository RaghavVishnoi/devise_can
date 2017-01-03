module DeviceCan
	module Generators
		module Common

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

		end
	end
end