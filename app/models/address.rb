class Address < ApplicationRecord
  belongs_to :contact

  validates :street, :number, :city, :neighborhood, :state, :zip_code, presence: true
  validates :latitude, :longitude, presence: true
end
