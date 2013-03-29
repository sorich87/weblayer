require 'test_helper'

class EditorTest < ActionDispatch::IntegrationTest
  before do
    require_js
    visit(root_path)
  end

  describe 'the device switch' do
    it 'has all the devices' do
      assert page.has_css?('.device-switch a', count: 3)
    end

    it 'has only one active device' do
      assert page.has_css?('.device-switch a.active', count: 1)
    end

    it 'has the pc active by default' do
      assert page.has_css?('.device-switch a.active[data-device=pc]')
    end

    it 'highlights the selected device' do
      element = first('.device-switch a:not(.active)')
      element.click
      assert page.has_css?('.device-switch a.active', count: 1)
      assert 'active', element['class']
    end

    it 'changes the iframe width' do
      page.evaluate_script('$.fx.off = true')
      old_width = page.evaluate_script('$("#app-preview iframe").width()')
      element = first('.device-switch a:not(.active)')
      element.click
      new_width = page.evaluate_script('$("#app-preview iframe").width()')
      assert_not_equal old_width, new_width
    end
  end
end

