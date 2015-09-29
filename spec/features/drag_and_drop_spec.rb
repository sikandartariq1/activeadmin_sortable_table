RSpec.describe ActiveAdmin::SortableTable, 'Drag-and-Drop', type: :feature do
  before do
    Category.create!
    Category.create!
    Category.create!
  end

  def ordered_elements
    Category.order(:position).pluck(:id)
  end

  context 'first page' do
    it 'reorder elements by dragging vertically', js: true do
      expect(ordered_elements).to eq([1, 2, 3])

      visit admin_categories_path

      expect(visible_elements).to eq([1, 2, 3])

      move_higher(2)

      expect(visible_elements).to eq([2, 1, 3])
      expect(ordered_elements).to eq([2, 1, 3])
    end
  end

  context 'second page' do
    before do
      Category.create!
      Category.create!
      Category.create!
    end

    it 'reorder elements by dragging vertically', js: true do
      expect(ordered_elements).to eq([1, 2, 3, 4, 5, 6])

      visit admin_categories_path(page: 2)

      expect(visible_elements).to eq([4, 5, 6])

      move_higher(5)

      expect(visible_elements).to eq([5, 4, 6])
      expect(ordered_elements).to eq([1, 2, 3, 5, 4, 6])
    end
  end

  private

  def visible_elements
    all('.ui-sortable-handle .col-id').map(&:text).map(&:to_i)
  end

  def move_higher(element_id)
    drag_element(element_id, dy: -200)
  end

  def drag_element(element_id, options)
    wait_for_ajax do
      options.reverse_merge! moves: 20
      page.execute_script(%($("#category_#{element_id} .handle").simulate("drag", #{options.to_json} )))
    end
  end
end
