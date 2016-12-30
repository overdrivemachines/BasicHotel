# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  name        :string
#  access_code :string
#  notes       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Property < ApplicationRecord
	has_one :address, as: :addressable, dependent: :destroy

	validates :name, presence: true
	validates :access_code, presence: true
end
