# frozen_string_literal: true

# Creates each player
class Player
  attr_reader :symbol
  attr_accessor :name

  def initialize(symbol = nil, name = nil)
    @symbol = symbol
    @name = name
  end
end
