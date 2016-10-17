module ProfileCompleteness
  extend ActiveSupport::Concern

  included do
    after_save :update_completeness
    after_destroy :update_completeness
  end

  def update_completeness
    user = self.class == User ? self : self.user
    percent = 0

    percent += user.photo.present? ? 20 : 0
    percent += user.profile.location.present? ? 10 : 0
    percent += (user.profile.facebook_link || user.profile.linkedin_link || user.profile.twitter_link || user.profile.google_plus_link).present? ? 5 : 0
    percent += user.overview.try(:objective).present? ? 15 : 0
    percent += user.educations.present? ? 20 : 0
    percent += user.experiences.present? ? 10 : 0
    percent += user.skills.present? ? 10 : 0
    percent += user.references.present? ? 5 : 0
    percent += user.languages.present? ? 5 : 0

    user.profile.update_column(:completeness, percent)
  end
end
