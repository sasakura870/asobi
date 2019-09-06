module UsersHelper
  def user_photo(user, size: 50)
    if user.photo?
      image_tag user.photo.url, size: "#{size}x#{size}"
    else
      image_pack_tag 'default_photo.png', size: "#{size}x#{size}"
    end
  end
end
