# frozen_string_literal: true
require './user'
class App
  def initialize(storage)
    @menus = {
      main: %w[Exit Login Register],
      logged_in: ["Exit", "Add Time", "Logout", "Back"]
    }
    @current_user = nil
    @current_menu = :main
    @storage = storage
    @storage.put "users", {}
  end

  def run
    puts "Started."
    puts

    show_current_menu
    listen_command
  end

  private
  def listen_command
    command_idx = gets.chomp
    exec_command command_idx.to_i
  end

  def exec_command(command_idx)
    selected = @menus[@current_menu][command_idx]

    if selected.nil?
      puts "Unknown command"
      puts

      show_current_menu
      listen_command
      return
    end

    puts "Selected \"#{selected}\""
    puts

    case selected
    when "Register" then register_user
    when "Logout" then log_out
    when "Login" then log_in
    when "Back" then back
    when "Exit" then nil
    else nil
    end
  end

  def back

  end

  def log_in
    print "User name (0 for Back) > "

    user_name = gets.chomp
    if user_name == "0"
      @current_menu = :main
      puts "Selected Back"
      puts
      show_current_menu
      listen_command
      return
    end

    users = @storage.get "users"

    if users[user_name]
      @current_menu = :logged_in
      @current_user = users[user_name]
      puts
      show_current_menu
      listen_command
    else
      puts "Unknown user"
      log_in
    end
  end

  def log_out
    @current_user = nil
    @current_menu = :main

    puts
    show_current_menu
    listen_command
  end

  def register_user
    print "Enter name: "
    name = gets.chomp

    new_user = User.new name
    users = @storage.get "users"
    users[name] = new_user
    @current_user = new_user
    @storage.put "users", users

    puts "Registered as #{name}"

    @current_menu = :logged_in

    puts
    show_current_menu
    listen_command
  end

  def show_current_menu
    user = @current_user ? "Logged in as #{@current_user.name}" : "Not logged in"
    puts "Menu: (#{user})"

    @menus[@current_menu].each_with_index { |val, idx| puts "  #{idx}: #{val}" }

    print "> "
  end
end
