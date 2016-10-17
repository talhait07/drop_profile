module ProfilesHelper
  def current_profile
    current_user.profile  rescue nil
  end

  def web_address(profile)
    profile.web_link.present? ? profile.web_link : profile_url(profile)
  end
end
