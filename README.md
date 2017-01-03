# DeviseCan

## Why **devise_can** gem?

By `device_can` gem you'll get functionality of devise,cancancan and `user_role_association` that make your development easy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_can'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise_can

## Usage

 You need to follow all given steps i.e.

 ## Generate devise component

 `rails generate devise:install`


 Now add `require 'devise'` to your config/application.rb



 `rails generate devise user`


 This will generate devise model with name `User`, you can either generate views and controller as well by following command:

 `rails generate devise:views`


 `rails generate devise:controllers users`



 ## Generate association component

 `rails generate association user_role`

  It'll generate two models with name `Role` and `UserRole`

  ```
  	class Role < ActiveRecord::Base
	    has_many :user_roles
	  	has_many :users,through: :user_roles

	    validates :name,presence: true
	end

  ```


  ```
  	class UserRole < ActiveRecord::Base
	  	belongs_to :user
	  	belongs_to :role
	  	validates :user,presence: true
	  	validates :role,presence: true
	  	validates_uniqueness_of  :user_id, scope: :role_id
	end

  ```

  Add association into model `User` i.e.

  ```
  	has_many :user_roles
    has_many :roles,through: :user_roles   

  ```



 ## Generate cancan component

 `rails generate cancan:ability`

 It'll create a model with name `Ability`


## Generate permission component

 `rails generate permission module`

 It'll generate three models with name `ModuleAction` , `ModuleGroup` and  `ModulePermission`.Each model looks like:

 ```

 	class ModuleAction < ApplicationRecord
		has_many :module_permissions
		has_many :module_groups,through: :module_permissions
	end

 ```

 	This model will contain all module name like `User` or `Role` etc..

 ```

 	class ModuleGroup < ApplicationRecord

		has_many :module_permissions
		has_many :module_actions,through: :module_permissions

	end

 ```

 	This model will contain all actions for controller like `create/new/index/update/show` etc..  

 ```

 	class ModulePermission < ApplicationRecord

		belongs_to :module_group
		belongs_to :module_action
		belongs_to :role

	end

 ```

 	This model will contain association between `module_group` , `module_action` and `role`.
 	 

 Now your ability.rb file should look like:

 ```

 	class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  
    if user.roles.pluck(:name).include?('superadmin')
        can :manage, :all
    else
        user.roles.map{|role| role.module_permissions}.each do |permissions|
            permissions.each do |permission|
                can permission.module_action.name.to_sym,permission.module_group.name.constantize
            end
        end
    end

    


  end
end


 ```

 Here superadmin is a role with all permissions on each module.

 ## Run migrations

 Now you need to run migrations for schema update

 `rails db:migrate`

 ## Other stuffs

  Add following lines into your application controller:

  ```

  	rescue_from CanCan::AccessDenied do |exception|
	  flash[:warning] = exception.message
	  redirect_to root_path
    end

  ```
  It'll check ability.rb on each action and reirect to `root_path` if found unpermitted action. 



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/devise_can. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

