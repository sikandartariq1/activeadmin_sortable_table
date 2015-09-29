RSpec.describe ActiveAdmin::SortableTable, 'Drag-and-Drop', type: :feature do
  before do
    Category.create!
    Category.create!
    Category.create!
  end

  def ordered_elements
    Category.order(:position).pluck(:id)
  end

  it 'reorder elements by dragging vertically', js: true do
    expect(ordered_elements).to eq([1, 2, 3])

    visit admin_categories_path

    expect(visible_elements).to eq([1, 2, 3])

    move_higher(2)

    expect(visible_elements).to eq([2, 1, 3])
    expect(ordered_elements).to eq([2, 1, 3])
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
