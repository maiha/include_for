require File.dirname(__FILE__) + '/../spec_helper'


describe IncludeFor, 'option付きのjs呼び出し' do
  before(:each) do
    @helper = Helper.new
  end

  it '1属性を指定' do
    @result = @helper.include_for('application.js', :language=>"JavaScript")
    @result.should == ['javascript_include_tag:"application.js",{:language=>"JavaScript"}']
  end

  it '2属性を指定' do
    @result = @helper.include_for('application.js', :language=>"JavaScript", :charset=>"UTF-8")
    @result.should == ['javascript_include_tag:"application.js",{:charset=>"UTF-8", :language=>"JavaScript"}']
  end
end


describe IncludeFor, 'option付きのcss呼び出し' do
  before(:each) do
    @helper = Helper.new
  end

  it '1属性を指定' do
    @result = @helper.include_for('application.css', :media=>"all")
    @result.should == ['stylesheet_link_tag:"application.css",{:media=>"all"}']
  end

  it '2属性を指定' do
    @result = @helper.include_for('application.css', :media=>"all", :charset=>"UTF-8")
    @result.should == ['stylesheet_link_tag:"application.css",{:charset=>"UTF-8", :media=>"all"}']
  end
end
