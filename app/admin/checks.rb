ActiveAdmin.register Check do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :type_check, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:type_check, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :type_check, as: :select, :collection => [['Check in', 1], ['Check out', 2], ['All', nil]], :include_blank => false
  filter :created_at, as: :date_range
  
  form title: 'New Check' do |f|
    f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.name, u.id]}, :include_blank => false
    f.input :type_check, :as => :select, :collection => [['Check in', 1], ['Check out', 2]], :include_blank => false
    actions
  end
  index do
    selectable_column
    column :id
    column :type_check do |r|
      r[:type_check] == 1 ? "Check in" : "Check out"
    end
    column :user_id do |r|
      User.find(r[:user_id])[:name]
    end
    column :created_at
    column :updated_at
    actions
  end
  show do
    attributes_table do
      row :type_check do |r|
        r[:type_check] == 1 ? "Check in" : "Check out"
      end
      row :user_id do |r|
        User.find(r[:user_id])[:name]
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
