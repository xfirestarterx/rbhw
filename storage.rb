# frozen_string_literal: true

module IStorage
  def put(key, value); end
  def get(key); end
end

class Storage
  include IStorage

  def initialize
    @data = {}
  end

  def put(key, value)
    @data[key] = value
  end

  def get(key)
    @data[key]
  end
end