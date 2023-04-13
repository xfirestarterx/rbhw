# frozen_string_literal: true
require './user'
require './storage'

class App
  def initialize(storage)
    @menus = {
      main: %w[Exit Login Register],
      logged_in: ["Exit", "Add Time", "Logout"]
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
    when "Exit" then nil
    else nil
    end
  end

  def log_in

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
    puts "Main menu: (#{user})"

    @menus[@current_menu].each_with_index { |val, idx| puts "  #{idx}: #{val}" }

    print "> "
  end
end

storage = Storage.new
app = App.new(storage)
app.run
