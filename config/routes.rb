Rails.application.routes.draw do
  resources :coupons

  resources :line_items

  resources :carts

  ActiveAdmin.routes(self)
  devise_for :users,
             :controllers => {
               omniauth_callbacks: 'users/omniauth_callbacks',
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               passwords: 'users/passwords',
               confirmations: 'users/confirmations'
             }

  resources :admin_contacts

  resources :hobbies_interests

  resources :countries

  resources :categories

  resources :advertisements

  # Dashboard
  get 'dashboard', to: 'dashboard#index', as: :user_root
  get 'dashboard/edit_profile', format: 'js'
  put 'dashboard/update_profile', format: 'js'

  resources :templates do
    member do
      get 'details'
      get 'activate'
      get 'add_to_my'
      delete 'remove_from_my'
    end
  end

  resources :languages

  resources :references

  resources :skills

  resources :experiences

  resources :educations

  resources :overviews

  root 'home#index'
  get 'home/load_states'
  get '/privacy-policy' => 'home#privacy_policy', as: :privacy_policy
  get 'terms-of-use' => 'home#terms_of_use', as: :terms_of_use
  get 'email-resume' => 'home#email_resume', as: :email_resume

  # sitemaps url
  get 'sitemap.xml' => 'home#sitemap', format: :xml, as: :sitemap
  get 'sitemaps/site.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'site' }
  get 'sitemaps/public_profiles.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'public_profiles' }
  get 'sitemaps/published_templates.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'published_templates' }
  get 'blog-sitemap.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'blog/sitemap' }
  get 'sitemaps/blog/site.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'blog/site' }
  get 'sitemaps/blog/blog_posts.xml' => 'home#sitemap', format: :xml, defaults: { file_name: 'blog/blog_posts' }
  get 'robots.txt' => 'home#robots', format: :text

  #tag url
  get 'tags/:tag', to: 'profiles#tag', as: :tag

  #send resume by email popover link
  get 'send-resume-by-email' => 'home#send_resume_by_email'

  # subscribe email to mailchimp
  post 'subscribe' => 'home#subscribe'

  # it must be placed in end of file, as path: ''
  resources :profiles, except: [:index, :destroy], path: '' do
    member do
      put 'update_profile_photo'
      put 'update_username'
    end

    collection do
      get 'set_objective'
    end
  end
end
