class ModuleAction < ApplicationRecord

	has_many :module_permissions
	has_many :module_groups,through: :module_permissions

end
