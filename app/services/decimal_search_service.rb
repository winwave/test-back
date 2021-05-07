# frozen_string_literal: true

class DecimalSearchService < ApplicationService
  private

  # AAA <=> 1+26^2 + 1*26 + 1 = 703, AAA is the first index in pseudo
  MIN_INDEX = 703

  def call
    arr_decimal_exists = User.all.pluck(:decimal_index).sort

    binary_search(arr_decimal_exists)
  end

  def binary_search(arr)
    return MIN_INDEX + arr.length if arr.last < MIN_INDEX + arr.length

    left = 0
    right = arr.length - 1
    while left <= right
      mid = ((left + right) / 2).floor
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
