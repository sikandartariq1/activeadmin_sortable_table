ActiveAdmin.register Category do
  permit_params :name, :position
  config.sort_order = 'position_asc'
  orderable

  index do
    orderable_handle_column
    id_column
    column :name
    actions
  end
end
