ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1

  content title: 'Dashboard' do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #   end
    # end

    columns do
      column do
        panel 'Recent Templates' do
          # table_for UserTemplate.select(:template_id).uniq.collect{|t| t.template}.sort{|a,b| b.users.count <=> a.users.count}.first(5) do
          table_for Template.all.sort_by{|u| -u.users.count}.first(5) do
            column('Title') { |template| link_to(template.name, admin_template_path(template)) }
            column('Last Update at') { |template| template.updated_at }
            column('Users') { |template| template.users.count }
          end
        end
      end

      column do
        panel 'Recent Users' do
          table_for User.order('created_at desc').limit(5) do
            column('Name') { |user| link_to(user.full_name, admin_user_path(user)) }
            column('Last Profile Update') { |user| user.profile.updated_at }
            column('Profile completion') { |user| "#{user.profile_completeness } %" }
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
