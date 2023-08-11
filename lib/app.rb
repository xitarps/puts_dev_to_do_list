require 'io/console'
require_relative 'models/menu'
require_relative 'models/task'
require_relative 'models/article'

class App
  attr_accessor :keep_going

  def initialize
    @keep_going = true
    @menu = Menu.new
  end

  def call
    run
  end

  private

  def run
    while keep_going
      STDOUT.clear_screen
      show_menu
      trigger_option if keep_going?
    end
  end

  def show_menu
    @menu.dispĺay_menu
  end

  def keep_going?
    @user_option = gets.chomp.to_i
    self.keep_going = false if @menu.options[@user_option] == :exit
    self.keep_going
  end

  def trigger_option
    STDOUT.clear_screen
    call_method_from_class
  end

  def call_method_from_class # list_task
    class_name = @menu.options[@user_option].to_s.split('_').last
    class_action = @menu.options[@user_option].to_s.split('_').first

    class_name = format_class_name(class_name)

    class_constant = Object.const_get(class_name)
    class_constant.send(class_action)
  end
  
  def format_class_name(class_name)
    if class_name.chars.last == 's'
      class_name.slice(0, class_name.length - 1).capitalize # Task
    else
      class_name.capitalize # Task
    end
  end
end

App.new.call