class HostReview < Review
  #host is going to make a Review to guest.
  belongs_to :host, class_name: "User"
end
