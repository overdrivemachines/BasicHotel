# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  room_number  :integer          not null
#  location     :string
#  vacant       :boolean          default("t"), not null
#  clean        :boolean          default("t"), not null
#  inventory    :boolean          default("t"), not null
#  room_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Room < ApplicationRecord
  belongs_to :room_type

  validates :room_number, presence: true
  validates :vacant, presence: true 
  validates :clean, presence: true
  validates :inventory, presence: true
end
