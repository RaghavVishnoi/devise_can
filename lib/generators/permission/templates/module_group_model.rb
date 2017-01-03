class ModuleGroup < ApplicationRecord

	has_many :module_permissions
	has_many :module_actions,through: :module_permissions

end
