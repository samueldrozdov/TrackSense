module UsersHelper

  def image_for(user, string)
    if @user.image.nil?
      image_tag("default-profile-image-1.png", class: string)
    else
      @user.image.url
    end
  end
end
