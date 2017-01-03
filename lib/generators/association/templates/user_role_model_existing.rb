  	belongs_to :user
  	belongs_to :role
  	validates :user,presence: true
  	validates :role,presence: true
  	validates_uniqueness_of  :user_id, scope: :role_id
