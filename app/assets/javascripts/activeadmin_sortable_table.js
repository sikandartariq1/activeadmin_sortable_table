(function($) {
  $(document).ready(function() {
    $('.handle').closest('tbody').activeAdminSortableTable();
  });

  $.fn.activeAdminSortableTable = function() {
    this.sortable({
      handle: ".handle",
      update: function(event, ui) {
        var item = ui.item.find('[data-sort-url]');
        var url = item.data('sort-url');
        var actionOnSuccess = item.data('sort-success-action');
        var customParams = {};
        if (typeof item.data('sort-custom-params') === 'object') {
          customParams = item.data('sort-custom-params');
        }

        $.ajax({
          url: url,
          type: 'post',
          data: $.extend(customParams, { position: ui.item.find('[data-position]').data('position') - 1 }),
          error: function() { console.error('Saving sortable error'); },
          success: function() {
            if (actionOnSuccess === 'noting') { return; }

            $("tr", $('.handle').closest('tbody')).removeClass('even odd');
            $("tr", $('.handle').closest('tbody')).filter(":even").addClass('odd');
            $("tr", $('.handle').closest('tbody')).filter(":odd").addClass('even');
          }
        });
      }
    });

    this.disableSelection();
  }
})(jQuery);
