# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
host CONFIG[:host]

sitemap :site do
  url root_url, last_mod: Time.now, change_freq: 'weekly', priority: 1.0
  url templates_url, last_mod: Time.now, change_freq: 'daily', priority: 0.9
  url new_user_session_url, last_mod: Time.now, change_freq: 'weekly', priority: 0.7
  url new_user_registration_url, last_mod: Time.now, change_freq: 'weekly', priority: 0.7
end

# You can have multiple sitemaps like the above – just make sure their names are different.

# Automatically link to all pages using the routes specified
# using "resources :pages" in config/routes.rb. This will also
# automatically set <lastmod> to the date and time in page.updated_at:
#
  # sitemap_for Template.scoped

# For products with special sitemap name and priority, and link to comments:
#
sitemap_for Template.published, name: :published_templates do |template|
  # url template, last_mod: template.updated_at, priority: (template.featured? ? 1.0 : 0.7)
  url template, last_mod: template.updated_at, priority: 0.8
  # url template_comments_url(template)
end

sitemap_for Profile.all_profiles, name: :public_profiles do |profile|
  # url template, last_mod: template.updated_at, priority: (template.featured? ? 1.0 : 0.7)
  url profile, last_mod: profile.updated_at, priority: 0.7  if profile.user.profile_completeness >= 0.5
  # url template_comments_url(template)
end

# If you want to generate multiple sitemaps in different folders (for example if you have
# more than one domain, you can specify a folder before the sitemap definitions:
# 
#   Site.all.each do |site|
#     folder "sitemaps/#{site.domain}"
#     host site.domain
#
#     sitemap :site do
#       url root_url
#     end
#
#     sitemap_for site.products.scoped
#   end

# Sitemap for blog posts
begin
  api_url = YAML.load_file('config/config_difference.yml')['blog']['site_urls']
  blog_response = HTTParty.get api_url
  site_urls = blog_response.parsed_response

  folder 'sitemaps/blog'

  sitemap :site do
    url site_urls['root'], last_mod: Time.now, priority: 0.8
  end

  sitemap :blog_posts do
    site_urls['posts'].each do |post|
      url post, last_mod: Time.now, priority: 0.7
    end
  end
rescue Exception => ex
  Rails.logger.error "Blog sitemap load: #{ex.message}"
end

# Ping search engines after sitemap generation:
#
ping_with "http://#{host}/sitemap.xml"
ping_with "http://#{host}/blog-sitemap.xml"
