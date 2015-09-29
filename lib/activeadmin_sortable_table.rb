require 'activeadmin'
require 'active_admin/sortable_table/version'
require 'rails/engine'

module ActiveAdmin
  module SortableTable
    module ControllerActions
      def orderable
        member_action :sort, method: :post do
          resource.insert_at params[:position].to_i
          head 200
        end
      end
    end

    module TableMethods
      HANDLE = '&#9776;'.html_safe

      def orderable_handle_column(options = {})
        column '', class: 'activeadmin_sortable_table' do |resource|
          content_tag :span, HANDLE, :class => 'handle', 'data-sort-url' => sort_url(options[:url], resource)
        end
      end

      private

      def sort_url(url, resource)
        if url.is_a?(Symbol)
          send(url, resource)
        elsif url.respond_to?(:call)
          url.call(resource)
        else
          sort_url, query_params = resource_path(resource).split('?', 2)
          sort_url += '/sort'
          sort_url += '?' + query_params if query_params
          sort_url
        end
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

    class Engine < ::Rails::Engine
      # Including an Engine tells Rails that this gem contains assets
    end
  end
end
