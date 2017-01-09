# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  username               :string           default(""), not null
#  firstname              :string           default(""), not null
#  lastname               :string           default(""), not null
#  property_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable, :lockable

	belongs_to :property, optional: true
	before_validation :set_username, on: :create

	before_validation do
		self.firstname.strip!
		self.lastname.strip!
		self.email.strip!
	end

	validates :firstname, presence: true
	validates :lastname, presence: true
	# Usernames can only be in the format dc366
	validates :username, presence: true, 
		uniqueness: true 
		# exclusion: { in: %w(admin superuser manager man mgr super user usr)	} #, 
		#format: { with: /[a-z]{2}[\d]{1,}/ }
	validates :email,
		uniqueness: true #, format: { with: // }

	private
		def set_username
			# raise self.inspect
			# TODO: Set the number
			if (self.firstname == nil) || (self.lastname == nil)
				self.username = "invalid"
			else
				self.username = self.firstname[0].downcase + self.lastname[0].downcase + (User.last.id + 1).to_s
			end
			# puts "*** Username = " + self.username
		end
end
