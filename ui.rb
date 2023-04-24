class UI
  MENUS = {
    main: %w[Exit Login Register],
    logged_in: %w[Exit Calendar Logout],
    calendar: %w[Show]
  }

  def initialize(on_command, before_show_menu, after_show_menu)
    @current_menu = :main
    @on_command = on_command
    @before_show = before_show_menu
    @after_show = after_show_menu
  end

  def show_menu(menu)
    @current_menu = menu
    @before_show.call

    MENUS[menu].each_with_index { |val, idx| puts "  #{idx + 1}: #{val}" }

    @after_show.call

    listen_command
  end

  def listen_command
    command = gets.chomp.to_i

    if command == 0
      puts "Wrong command"
      puts

      show_menu @current_menu
      return
    end

    selected = MENUS[@current_menu][command - 1]

    unless selected
      puts "Unknown command"
      puts

      show_menu @current_menu
      return
    end

    @on_command.call(self, selected)
  end
end