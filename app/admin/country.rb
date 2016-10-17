ActiveAdmin.register Country do
  menu parent: 'Advertisement'

  permit_params :code

  index do
    selectable_column
    column :code
    column 'Name' do |country|
      Carmen::Country.coded(country.code).try(:name)
    end
    column 'Use in advertisement' do |country|
      country.advertisements.count
    end
    actions
  end

  show do
    attributes_table do
      row :code
      row 'Name' do |ad|
        Carmen::Country.coded(country.code).try(:name)
      end
      row 'Use in advertisement' do |country|
        country.advertisements.count
      end
      row :created_at
      row :updated_at
    end
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.country_select :code
      f.actions
    end
  end
end
