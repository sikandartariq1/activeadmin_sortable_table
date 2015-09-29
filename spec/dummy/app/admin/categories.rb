ActiveAdmin.register Category do
  include ActiveAdmin::SortableTable
  permit_params :name, :position
  config.sort_order = 'position_asc'

  index do
    handle_column
    id_column
    column :name
    actions
  end
end
