ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
    permit_params :email, :name, :position, :enabled, :private_number, :company_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :name, :position, :enabled, :private_number, :company_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form title: 'New User' do |f|
    f.input :company_id, :as => :select, :collection => Company.all.map {|u| [u.name, u.id]}, :include_blank => false
    f.input :private_number, input_html: {value: Time.now.to_i, readonly: true}
    f.input :email
    f.input :name
    f.input :position
    f.input :enabled, :as => :radio, :collection => [['Yes', 1], ['No', 0]]
    actions
  end
  index do
    selectable_column
    column :id
    column :name
    column :private_number
    column :email
    column :position
    column :enabled do |r|
      status_tag(r[:enabled] == 1 ? "Yes" : "No")
    end
    column :company_id do |r|
      Company.find(r[:company_id])[:name]
    end
    column :created_at
    column :updated_at
    actions
  end
  show do
    attributes_table do
      row :name
      row :private_number
      row :email
      row :position
      row :enabled do |r|
        status_tag(r[:enabled] == 1 ? "Yes" : "No")
      end
      row :company_id do |r|
        Company.find(r[:company_id])[:name]
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end