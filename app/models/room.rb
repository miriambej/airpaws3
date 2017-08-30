class Room < ApplicationRecord
  belongs_to :user
  has_many :photos

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

end
