ActiveAdmin.register User do

  member_action :recommended_user, method: :put do
    @user = User.find(params[:id])
    @user.recommend = params[:recommend]
    @user.save(:validate => false)
    redirect_to admin_users_path, notice: "User is hidden from home most viewed users."
  end

  menu priority: 3, label: 'Users'

  permit_params :full_name, :username, :email

  actions :index, :show

  index do
    column 'Full Name' do |user|
      link_to user.full_name, admin_user_path(user)
    end
    column :username
    column :email
    column 'Sign up with' do |user|
      user.auth_provider.present? ? user.auth_provider : 'Dropresume'
    end
    column 'Profile Photo' do |user|
      image_tag user.photo.url(:thumb)
    end
    column 'Active template' do |user|
      "<span style='float: left'>#{user.active_template.name}</span></br>
       <div class='template-color' style='background-color: ##{user.template_color};'></div>".html_safe
    end
    column 'Profile complete' do |user|
      "#{user.profile_completeness} %"
    end
    column 'Profile views' do |user|
      user.profile.impressionist_count
    end
    column 'Action' do |user|
      if user.recommend
        link_to "Hide", recommended_user_admin_user_path(user, :recommend => false), :method => :put
      else
        link_to "Show", recommended_user_admin_user_path(user, :recommend => true), :method => :put
      end
    end
  end

  show do
    attributes_table do
      row :full_name
      row :username
      row :email
      row 'Profile Photo' do |user|
        image_tag user.photo.url
      end
      row 'Address' do |user|
        user.profile.location
      end
      row 'Active template' do |user|
        "<span style='float: left'>#{user.active_template.name}</span>
       <div class='template-color' style='background-color: ##{user.template_color};'></div>".html_safe
      end
      row 'Profile complete' do |user|
        "#{user.profile_completeness} %"
      end
      row :last_sign_in_at
      row :sign_in_count
      row 'User from' do |user|
        user.created_at
      end
      row 'Sign up with' do |user|
        user.auth_provider.present? ? user.auth_provider : 'Dropresume'
      end
      row 'Profile visitor' do |user|
        user.count_profile_viewer
      end
      row 'Public Profile' do |user|
        link_to 'Visit resume', profile_path(user.profile), target: '_blank'
      end
    end
  end
end
