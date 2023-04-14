# frozen_string_literal: true
require './storage'
require './app'

storage = Storage.new
app = App.new(storage)
app.run
