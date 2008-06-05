require File.dirname(__FILE__) + '/../spec_helper'


describe IncludeFor, '例外的な指定' do
  before(:each) do
    @helper = Helper.new
  end

  it ':defaults はシンボルとして受理される' do
    @result = @helper.include_for(:defaults)
    @result.should ==
      ['javascript_include_tag::defaults']
  end

  it '末尾が js,css でない文字列はそのまま出力される' do
    @result = @helper.include_for("alert('ok')")
    @result.should ==
      ["alert('ok')"]
  end
end

