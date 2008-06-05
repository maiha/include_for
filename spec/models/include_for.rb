require File.dirname(__FILE__) + '/../spec_helper'

describe IncludeFor, '直接JSファイル名を指定すると' do
  before(:each) do
    @helper = Helper.new
  end

  it 'javascript_include_tag の実行結果が配列で返る' do
    @result = @helper.include_for('application.js')
    @result.should ==
      ['javascript_include_tag:"application.js"']
  end

  it '複数のファイルを指定できる' do
    @result = @helper.include_for('prototype.js', 'controls.js')
    @result.should ==
      ['javascript_include_tag:"prototype.js"',
       'javascript_include_tag:"controls.js"']
  end

  it '複数のファイルの順序も保存される' do
    @result = @helper.include_for('controls.js', 'prototype.js')
    @result.should ==
      ['javascript_include_tag:"controls.js"',
       'javascript_include_tag:"prototype.js"']
  end

  it '重複するファイルは最初の1つだけが有効になる' do
    @result = @helper.include_for('controls.js', 'prototype.js',  'prototype.js')
    @result.should ==
      ['javascript_include_tag:"controls.js"',
       'javascript_include_tag:"prototype.js"']
  end

  it '複数回に分割して実行すると最後だけが有効' do
    @result = @helper.include_for('controls.js')
    @result = @helper.include_for('prototype.js')
    @result.should ==
      ['javascript_include_tag:"prototype.js"']
  end

  it '複数回に分割して実行して最後が重複している場合でも返される' do
    @result = @helper.include_for('prototype.js')
    @result = @helper.include_for('controls.js')
    @result = @helper.include_for('prototype.js')
    @result.should ==
      ['javascript_include_tag:"prototype.js"']
  end
end


describe IncludeFor, '直接CSSファイル名を指定すると' do
  before(:each) do
    @helper = Helper.new
  end

  it 'stylesheet_link_tag の実行結果が配列で返る' do
    @result = @helper.include_for('application.css')
    @result.should ==
      ['stylesheet_link_tag:"application.css"']
  end

  it '複数のファイルを指定できる' do
    @result = @helper.include_for('prototype.css', 'controls.css')
    @result.should ==
      ['stylesheet_link_tag:"prototype.css"',
       'stylesheet_link_tag:"controls.css"']
  end

  it '複数のファイルの順序も保存される' do
    @result = @helper.include_for('controls.css', 'prototype.css')
    @result.should ==
      ['stylesheet_link_tag:"controls.css"',
       'stylesheet_link_tag:"prototype.css"']
  end

  it '重複するファイルは最初の1つだけが有効になる' do
    @result = @helper.include_for('controls.css', 'prototype.css',  'prototype.css')
    @result.should ==
      ['stylesheet_link_tag:"controls.css"',
       'stylesheet_link_tag:"prototype.css"']
  end
end


describe IncludeFor, '直接JSとCSSファイル名を指定すると' do
  before(:each) do
    @helper = Helper.new
  end

  it 'それぞれの結果が配列で返る' do
    @result = @helper.include_for('prototype.js', 'application.css', 'controls.js', 'application.js')
    @result.should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"',
       'javascript_include_tag:"controls.js"',
       'javascript_include_tag:"application.js"']
  end
end


