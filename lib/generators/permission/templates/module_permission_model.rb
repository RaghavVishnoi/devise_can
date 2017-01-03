class ModulePermission < ApplicationRecord

	belongs_to :module_group
	belongs_to :module_action
	belongs_to :role

end
