# == Schema Information
#
# Table name: room_types
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :string(4)
#  description :string
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class RoomType < ApplicationRecord
  belongs_to :property
  before_save :convert_code_to_upper_case

  validates :name, presence: true
  validates :code, presence: true, :length => { :maximum => 4 }
  validates :description, presence: true

  private
  def convert_code_to_upper_case
  	self.code.upcase!
  end
end
