module UsersHelper
  def user_photo(user, size: 50, class_name: '')
    if user.photo.attached?
      image_tag user.photo, size: "#{size}x#{size}", class: class_name
    else
      image_pack_tag 'default_photo.png', size: "#{size}x#{size}", class: class_name
    end
  end

  def user_name_format(user)
    user.nick_name.present? ? user.nick_name : "@#{user.name}"
  end
end
