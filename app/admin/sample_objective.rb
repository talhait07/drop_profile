ActiveAdmin.register SampleObjective do
  menu priority: 5, label: 'Sample Objectives'

  permit_params :objective, :tag_list

  index do
    selectable_column
    column :objective
    column :tag_list
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :objective
      row :tag_list
      row :created_at
      row :updated_at
    end
  end

  # New or Edit Template Form
  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :objective
      f.input :tag_list, label: "Tags"
        # and the other irrelevant fields goes here

      f.actions
    end
  end

end
