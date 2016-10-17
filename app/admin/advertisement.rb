ActiveAdmin.register Advertisement do
  menu priority: 4, parent: 'Advertisement', label: 'All Advertisements'

  permit_params :title, :image, :url, :third_party_name, :third_party_code, :all_country, :all_category, {:country_ids => []}, {:category_ids => []}

  index do
    selectable_column
    column auto_link :title
    column 'Image' do |ad|
      image_tag ad.image_url(:thumb), height: 50
    end
    column 'Link' do |ad|
      link_to ad.url, ad.url
    end
    column 'Categories' do |ad|
      ad.categories.pluck(:title).join(', ')
    end
    column :all_category
    column 'Countries' do |ad|
      ad.countries.pluck(:code).join(', ')
    end
    column :all_country
    actions
  end

  show do
    attributes_table do
      row auto_link :title
      row 'Image' do |ad|
        image_tag ad.image_url(:thumb), height: 50
      end
      row 'Link' do |ad|
        link_to ad.url, ad.url
      end
      row 'Categories' do |ad|
        ad.categories.pluck(:title).join(', ')
      end
      row :all_category
      row 'Countries' do |ad|
        ad.countries.pluck(:code).join(', ')
      end
      row :all_country
    end
  end

  # New or Edit Advertisement Form
  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
      f.input :url
      f.input :country_ids, as: :select, collection: Country.all.map { |country| [Carmen::Country.coded(country.code).name, country.id] }, input_html: { class: 'chosen-select' }, multiple: true
      f.input :all_country
      f.input :categories, input_html: { class: 'chosen-select' }, multiple: true
      f.input :all_category
      f.actions
    end
  end
end
