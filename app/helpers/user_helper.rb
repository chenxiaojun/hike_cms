module UserHelper
  def avatar(src, options = {})
    html_options = { class: 'img-circle', size: 60 }.merge(options)
    image_tag(src.presence || 'default_avatar.jpg', html_options)
  end

  def avatar_profile(user, options = {})
    avatar_path = user.avatar_path.presence || 'default_avatar.jpg'
    link_to avatar(avatar_path, options), profile_admin_user_path(user), remote: true
  end
end