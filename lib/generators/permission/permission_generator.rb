require 'rails/generators/active_record'
class PermissionGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"	


  def copy_module_group_migration
  	
  end

  def copy_module_action_migration

  end

  def copy_module_permission_migration

  end

end