ActiveAdmin.register Template do
  menu priority: 2, label: 'Templates'

  permit_params :name, :style, :price, :colors, :formatted_file, :image, :is_published

  index do
    selectable_column
    column auto_link :name
    column do |template|
      image_tag template.image_url(:thumb), height: 50
    end
    column :price
    column 'Colors' do |template|
      template.color_codes.map do |code|
        "<div class='template-color' style='background-color: ##{code};'></div>"
      end.join(' ').html_safe
    end
    column 'Active user' do |template|
      template.active_user_count
    end
    column :is_published
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :style
      row :price
      row 'Colors' do |template|
        template.color_codes.map do |code|
          "<div class='template-color' style='background-color: ##{code};'></div>"
        end.join(' ').html_safe
      end
      row 'Partial file name' do |template|
        template.formatted_file
      end
      row 'Image' do |template|
        image_tag template.image_url(:thumb)
      end
      row :active_user_count
      row :is_published
      row 'Show original design' do |template|
        link_to 'Go to template', template_path(template), target: '_blank'
      end
    end
  end

  # New or Edit Template Form
  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :style
      f.input :colors, as: :string
      f.input :formatted_file
      f.input :price
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
      f.input :is_published
      f.actions
    end
  end

end
