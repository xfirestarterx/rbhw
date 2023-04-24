class CalendarManager
  def initialize
    @storage = {}
  end

  def get(user_name)
    @storage[user_name]
  end
end
