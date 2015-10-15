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
    it 'reorders elements by dragging vertically by handle', js: true do
      expect(ordered_elements).to eq([1, 2, 3])

      visit admin_categories_path

      expect(visible_elements).to eq([1, 2, 3])
      expect(visible_positions).to eq([1, 2, 3])

      move_higher(2, by_handle: true)

      expect(visible_elements).to eq([2, 1, 3])
      expect(visible_positions).to eq([1, 2, 3])
      expect(ordered_elements).to eq([2, 1, 3])
    end

    it 'does not reorder elements by dragging vertically by row', js: true do
      expect(ordered_elements).to eq([1, 2, 3])

      visit admin_categories_path

      expect(visible_elements).to eq([1, 2, 3])
      expect(visible_positions).to eq([1, 2, 3])

      move_higher(2, by_handle: false)

      expect(visible_elements).to eq([1, 2, 3])
      expect(visible_positions).to eq([1, 2, 3])
      expect(ordered_elements).to eq([1, 2, 3])
    end
  end

  context 'second page' do
    before do
      Category.create!
      Category.create!
      Category.create!
    end

    it 'reorders elements by dragging vertically by handle', js: true do
      expect(ordered_elements).to eq([1, 2, 3, 4, 5, 6])

      visit admin_categories_path(page: 2)

      expect(visible_elements).to eq([4, 5, 6])
      expect(visible_positions).to eq([4, 5, 6])

      move_higher(5, by_handle: true)

      expect(visible_elements).to eq([5, 4, 6])
      expect(visible_positions).to eq([4, 5, 6])
      expect(ordered_elements).to eq([1, 2, 3, 5, 4, 6])
    end

    it 'does not reorder elements by dragging vertically by row', js: true do
      expect(ordered_elements).to eq([1, 2, 3, 4, 5, 6])

      visit admin_categories_path(page: 2)

      expect(visible_elements).to eq([4, 5, 6])
      expect(visible_positions).to eq([4, 5, 6])

      move_higher(5, by_handle: false)

      expect(visible_elements).to eq([4, 5, 6])
      expect(visible_positions).to eq([4, 5, 6])
      expect(ordered_elements).to eq([1, 2, 3, 4, 5, 6])
    end
  end

  private

  def visible_elements
    all('.ui-sortable .col-id').map(&:text).map(&:to_i)
  end

  def visible_positions
    all('.ui-sortable .col-position').map(&:text).map(&:to_i)
  end

  def move_higher(element_id, by_handle:)
    drag_element(element_id, by_handle, dy: -200)
  end

  def drag_element(element_id, by_handle, options)
    options.reverse_merge! moves: 20
    selector = by_handle ? "#category_#{element_id} .handle" : "#category_#{element_id}"
    page.execute_script(%($("#{selector}").simulate("drag", #{options.to_json})))
  end
end
