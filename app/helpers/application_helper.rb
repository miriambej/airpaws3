module ApplicationHelper
  def avatar_url(user) #we get the user.email by the user input parameter

    if user.image
      "http://graph.facebook.com/#{user.id}/picture?type=large" #display facebook image
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase #we use Digest::MD5::hexdigest method from rails to put the gravatar id
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150" # we return thre string and the syntax as a link.
    end
  end
end
