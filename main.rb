require './user'
require './user_manager'
require './calendar'
require './calendar_manager'
require './ui'

user_manager = UserManager.new
calendar_manager = CalendarManager.new

command_handler = proc { |ui, selected|
  puts "Selected \"#{selected}\""
  puts

  case selected
  when "Register" then
    user_manager.register
    ui.show_menu :logged_in
  when "Logout" then
    user_manager.log_out
    ui.show_menu :main
  when "Login" then
    result = user_manager.log_in
    if result
      ui.show_menu :logged_in
    else
      ui.show_menu :main
    end
  when "Calendar" then
    nil
  when "Exit" then nil
  else nil
  end
}

before_menu_show = proc {
  current_user = user_manager.get_current_user
  user_hint = current_user ? "Logged in as #{current_user.name}" : "Not logged in"

  puts "Menu: (#{user_hint})"
}

after_menu_show = proc {
  print "> "
}

menu = UI.new(command_handler, before_menu_show, after_menu_show)

menu.show_menu :main
