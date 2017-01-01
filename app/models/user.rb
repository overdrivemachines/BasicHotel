class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable, :lockable

	belongs_to :property
	before_validation :set_username, on: :create

	before_validation do
		firstname.strip!
		lastname.strip!
		email.strip!
	end

	validates :firstname, presence: true
	validates :lastname, presence: true
	# Usernames can only be in the format dc366
	validates :username, presence: true, 
		uniqueness: true, 
		exclusion: { in: %w(admin superuser manager man mgr super user usr)	}, 
		format: { with: /[a-z]{2}[\d]{2,}/ }
	validates :email, presence: true,
		uniqueness: true,
		format: { with: // }

	private
		def set_username
			username = firstname[0] + lastname[0] + "10"
		end
end
