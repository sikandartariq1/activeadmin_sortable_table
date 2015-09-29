module ActiveAdmin
  #
  module SortableTable
    # Adds `handle_column` method to `TableFor` dsl.
    # @example on index page
    #   index do
    #     handle_column
    #     id_column
    #     # other columns...
    #   end
    #
    # @example table_for
    #   table_for c.collection_memberships do
    #     handle_column
    #     # other columns...
    #   end
    #
    module HandleColumn
      HANDLE = '&#9776;'.html_safe

      # @param [Hash] options
      # @option options [Symbol, Proc, String] :url
      #
      def handle_column(options = {})
        column '', class: 'activeadmin_sortable_table' do |resource|
          content_tag :span, HANDLE, class: 'handle', 'data-sort-url' => sort_url(options[:url], resource)
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

    ::ActiveAdmin::Views::TableFor.send(:include, HandleColumn)
  end
end
