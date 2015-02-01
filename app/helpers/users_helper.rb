module UsersHelper

  def image_for(user)
    if @user.image.nil?
      image_tag("default-profile-image-1.png")
    else
      @user.image.url
    end
  end
end
