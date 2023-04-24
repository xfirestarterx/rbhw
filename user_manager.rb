class UserManager
  def initialize
    @users = {}
  end
  def get_current_user
    @current_user
  end

  def register
    print "Enter name: "
    name = gets.chomp
    create(name)
  end

  def log_in
    puts "Enter name: (0 for back)"
    print "> "
    name = gets.chomp

    if name == "0"
      return false
    end

    if !@users[name]
      puts "Unknown user"
      log_in
    else
      @current_user = @users[name]
      puts "Logged in"
      return true
    end
  end

  def log_out
    @current_user = nil
  end

  private
  attr_accessor :current_user

  def create(name)
    @users[name] = User.new name
    @current_user = @users[name]
    puts "Success"
  end
end