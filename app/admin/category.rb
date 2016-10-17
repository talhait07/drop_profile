ActiveAdmin.register Category do
  menu parent: 'Advertisement'

  permit_params :title

  index do
    selectable_column
    column :title
    column 'Uses in Advertisement' do |cat|
      cat.advertisements.count
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row 'Uses in Advertisement' do |cat|
        cat.advertisements.count
      end
      row :created_at
      row :updated_at
    end
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.actions
    end
  end
end
