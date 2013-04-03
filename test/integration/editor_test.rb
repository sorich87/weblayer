require 'test_helper'

class EditorTest < ActionDispatch::IntegrationTest
  before do
    require_js
    visit(root_path)
  end

  describe 'the device switch' do
    it 'has all the devices' do
      assert page.has_css?('.devices a', count: 3)
    end

    it 'highlights the selected device' do
      element = first('.devices li:not(.active) a')
      element.click
      assert 'active', element[:class]
      assert page.has_css?('.devices li.active', count: 1)
    end

    it 'changes the iframe width' do
      page.evaluate_script('$.fx.off = true')
      old_width = page.evaluate_script('$("#app-preview iframe").width()')
      element = first('.devices li:not(.active) a')
      element.click
      sleep 0.5
      new_width = page.evaluate_script('$("#app-preview iframe").width()')
      assert_not_equal old_width, new_width
    end
  end
end

