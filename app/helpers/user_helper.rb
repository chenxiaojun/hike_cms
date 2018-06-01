module UserHelper
  def avatar(src, options = {})
    html_options = { class: 'img-circle', size: 60 }.merge(options)
    src.present? ? image_tag(src, html_options) : ''
  end

  def avatar_profile(user, options = {})
    link_to avatar(user.avatar_path, options), profile_admin_user_path(user), remote: true
  end
end