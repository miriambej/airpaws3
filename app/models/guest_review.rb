class GuestReview < Review
  # guest is like an alias and it  is linked to user
  belongs_to :guest, class_name: "User"
end
