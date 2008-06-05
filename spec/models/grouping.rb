require File.dirname(__FILE__) + '/../spec_helper'


describe IncludeFor, 'ファイルはデフォルトで :header グループ' do
  before(:each) do
    @helper = Helper.new
  end

  it '1ファイルの指定' do
    @helper.include_for('prototype.js')
    @helper.instance_variable_get('@content_for_header').should ==
      'javascript_include_tag:"prototype.js"'
  end

  it '複数のファイルを指定した場合' do
    @helper.include_for('prototype.js', 'controls.js')
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'javascript_include_tag:"controls.js"'].join
  end

  it '複数のファイルを指定した場合(JSとCSS混在)' do
    @helper.include_for('prototype.js', 'application.css', 'controls.js')
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"',
       'javascript_include_tag:"controls.js"'].join
  end

  it '重複分は無視される' do
    @helper.include_for('prototype.js', 'application.css', 'controls.js', 'application.css', 'prototype.js')
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"',
       'javascript_include_tag:"controls.js"'].join
  end
end


describe IncludeFor, ':header グループの明示' do
  before(:each) do
    @helper = Helper.new
  end

  it '1ファイルの指定' do
    @helper.include_for('prototype.js', :to=>:header)
    @helper.instance_variable_get('@content_for_header').should ==
      'javascript_include_tag:"prototype.js"'
  end

  it '複数のファイルを指定した場合' do
    @helper.include_for('prototype.js', 'controls.js', :to=>:header)
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'javascript_include_tag:"controls.js"'].join
  end

  it '複数のファイルを指定した場合(JSとCSS混在)' do
    @helper.include_for('prototype.js', 'application.css', 'controls.js', :to=>:header)
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"',
       'javascript_include_tag:"controls.js"'].join
  end

  it '重複分は無視される' do
    @helper.include_for('prototype.js', 'application.css', 'controls.js', 'application.css', 'prototype.js', :to=>:header)
    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"',
       'javascript_include_tag:"controls.js"'].join
  end
end

describe IncludeFor, '別のグループ名の場合' do
  before(:each) do
    @helper = Helper.new
  end

  it ':footerに追加しても同じ出力を得る' do
    @helper.include_for('prototype.js', :to=>:footer).should ==
      ['javascript_include_tag:"prototype.js"']
  end

  it ':footerに追加したものは:footerに入る' do
    @helper.include_for('prototype.js', :to=>:footer)
    @helper.instance_variable_get('@content_for_footer').should ==
      ['javascript_include_tag:"prototype.js"'].join
  end

  it ':footerに追加したものは:headerには影響を与えない' do
    @helper.include_for('prototype.js', :to=>:footer)
    @helper.instance_variable_get('@content_for_header').should ==
      nil
  end

  it ':headerと:footerにそれぞれ追加しても出力は独立している' do
    @helper.include_for('prototype.js', :to=>:header)
    @helper.include_for('controls.js', :to=>:footer)
    @helper.include_for('application.css', :to=>:header)
    @helper.include_for('defaults.css', :to=>:footer)

    @helper.instance_variable_get('@content_for_header').should ==
      ['javascript_include_tag:"prototype.js"',
       'stylesheet_link_tag:"application.css"'].join

    @helper.instance_variable_get('@content_for_footer').should ==
      ['javascript_include_tag:"controls.js"',
       'stylesheet_link_tag:"defaults.css"'].join
  end
end
