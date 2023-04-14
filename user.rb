# frozen_string_literal: true

class User
  def initialize(name)
    @name = name
    @provided_slots = []
    @booked_slots = []
  end

  attr_reader :name
  attr_accessor :provided_slots
  attr_accessor :booked_slots
end
