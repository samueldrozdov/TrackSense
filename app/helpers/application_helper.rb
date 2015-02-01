module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Track Sense"
    if page_title.empty?
      base_title
    else
      "#{page_title}"
    end
  end

  # Returns the profile image of a user and adds a class to the image tag
  def image_for_user(user, string)
    if user.image.nil?
      image_tag("default-profile-image-1.png", class: string)
    else
      user.image.url
    end
  end

end
