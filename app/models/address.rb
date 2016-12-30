# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  address1         :string
#  address2         :string
#  city             :string
#  state            :string
#  zip              :string
#  country          :string
#  phone            :string
#  fax              :string
#  email            :string
#  addressable_type :string
#  addressable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ApplicationRecord
	belongs_to :addressable, polymorphic: true
	# Normalizes the attribute itself before validation
	phony_normalize :phone, default_country_code: 'US'
	phony_normalize :fax, default_country_code: 'US'
	
	validates :address1, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :country, presence: true
	validates :phone, presence: true, phony_plausible: true

end
