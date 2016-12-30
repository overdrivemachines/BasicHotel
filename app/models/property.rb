class Property < ApplicationRecord
	has_one :address, as: :addressable
end
