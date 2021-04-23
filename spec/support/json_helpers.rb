# frozen_string_literal: true

def body_as_json
  Oj.load(response.body)
end
