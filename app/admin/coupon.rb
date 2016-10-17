ActiveAdmin.register Coupon do
  menu priority: 6, label: 'Generate Coupon'

  permit_params :code, :discount_amount

  index do
    selectable_column
    column :code
    column :discount_amount
    actions
  end

  show do
    attributes_table do
      row :code
      row :discount_amount
      row :created_at
      row :updated_at
    end
  end

  # New or Edit Template Form
  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :code
      f.input :discount_amount
      f.actions
    end
  end

end
