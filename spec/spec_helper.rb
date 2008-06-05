
# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.

require 'rubygems'

ENV["RAILS_ENV"] = "test"
# require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
gem 'activesupport'
require 'active_support'

gem 'actionpack'
require 'action_controller'
require 'action_view'

gem 'rspec'
# require 'autotest'
# require 'autotest/redgreen'

require File.expand_path(File.dirname(__FILE__) + "/../lib/include_for")
$: << File.expand_path(File.dirname(__FILE__) + "/models")


class Helper
  include IncludeFor
  include ActionView::Helpers::CaptureHelper

  def initialize
    @counts = Hash.new(){0}
  end

  def count_for(type)
    @counts[type]
  end

  ######################################################################
  ### Mocks

  def javascript_include_tag(*args)
    @counts[:js] += 1
    "javascript_include_tag:" + inspect_args(args)
  end

  def stylesheet_link_tag(*args)
    @counts[:css] += 1
    "stylesheet_link_tag:" + inspect_args(args)
  end

  private
    def inspect_args(args)
      options = args.last
      if options.is_a?(Hash)
        if options.blank?
          # strip an empty hash argument
          args.pop
        else
          # sort hash keys in inspect (dirty hack)
          sorted = options.inspect.sub(/^\{/, '').sub(/\}$/, '').split(/, /).sort.join(', ')
          return (args[0..-2].map(&:inspect) + ["{%s}" % sorted]).join(',')
        end
      end
      args.map(&:inspect).join(',')
    end
end

