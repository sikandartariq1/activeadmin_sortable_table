RSpec.describe 'ActiveAdmin::SortableTable', type: :feature do
  let!(:bottom) { Category.create!(name: 'bottom', position: 0) }
  let!(:top) { Category.create!(name: 'top', position: 1) }
  let!(:middle) { Category.create!(name: 'middle', position: 2) }

  before do
    visit admin_categories_path
  end

  it 'reorder elements by dragging vertically', js: true do
    expect(displayed_names).to eq(%w(top middle bottom))

    drag_element(middle, dy: -200)

    expect(displayed_names).to eq(%w(middle top bottom))
    expect(Category.order(:position).map(&:name)).to eq(%w(middle top bottom))
  end

  private

  def displayed_names
    all('.ui-sortable-handle .col-name').map(&:text)
  end

  def drag_element(element, options)
    wait_for_ajax do
      options.reverse_merge! moves: 20
      page.execute_script(%($("#category_#{element.id} .handle").simulate("drag", #{options.to_json} )))
    end
  end
end
