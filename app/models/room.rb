class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations

  has_many :guest_reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :accommodate, presence: true

  def cover_photo(size)  #we are using this method in index.html.erb
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end

  def average_rating
    # .average is a rails method.
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end

end
