class User < ApplicationRecord

  REGEXP_PSEUDO = /[A-Z]/.freeze
  PSEUDO_LENGTH = 3

  include Utils

  validates :pseudo, format: { with: REGEXP_PSEUDO }, length: { is: PSEUDO_LENGTH }

  def find_decimal_index_available
    arr_dec = User.all.pluck(:decimal_index).sort
    if arr_dec.last < MIN_INDEX + arr_dec.length
      return MIN_INDEX + arr_dec.length
    end

    binary_search(arr_dec)
  end

  def create_new_pseudo
    decimal_index = find_decimal_index_available
    pseudo = decimal_to_pseudo(decimal_index)

    self.update(pseudo: pseudo, decimal_index: decimal_index)
  end

  def add_decimal_index(pseudo)
    decimal_index = pseudo_to_decimal(pseudo)

    self.update(decimal_index: decimal_index)
  end
end
