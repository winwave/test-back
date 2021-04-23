module Utils
  extend ActiveSupport::Concern
  ##########################################################################
  # CONSTANTS
  ##########################################################################
  AZ_ARRAY = ('A'..'Z').to_a
  AZ_LENGTH = AZ_ARRAY.length
  MIN_INDEX = 703

  ###################################################################
  # METHODS
  ###################################################################
  def pseudo_to_decimal(pseudo)
    decimal_value = 0
    pseudo.split('').each_with_index do |letter, index|
      power = pseudo.length - index - 1
      decimal_value += letter_to_decimal(letter) * (AZ_LENGTH ** power)
    end

    decimal_value
  end

  def decimal_to_pseudo(number)
    pseudo = []
    while number > 0
      index = (number % AZ_LENGTH) - 1
      pseudo << AZ_ARRAY[index]
      number /= AZ_LENGTH
    end

    pseudo.reverse.join
  end

  def letter_to_decimal(letter)
    AZ_ARRAY.index(letter) + 1
  end

  def decimal_to_letter(number)
    index = number - 1

    AZ_ARRAY[index]
  end

  def binary_search(arr)
    left = 0
    right = arr.length - 1
    while left <= right
      mid = ((left + right)/2).floor
      dec_index = MIN_INDEX + mid
      if arr[mid] == dec_index
        return dec_index + 1 if arr[mid + 1] > dec_index + 1

        left = mid + 1
      else
        right = mid - 1
      end
    end
  end
end