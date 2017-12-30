class PhoneCode
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def valid?
    code.first.to_i.between? 2, 9
  end
end

class InternationalCountry < PhoneCode
  attr_reader :valid

  def initialize(code)
    @code = []
    @valid = code.first .to_i == 1
  end

  def valid?
    valid
  end
end

class Area < PhoneCode
end

class Local < PhoneCode
end

class PhoneNumber
  def self.clean(phone_number)
    numbers = phone_number.scan(/\d/)
    phone_number_parts = case numbers.length
      when 10
        [
          Area.new(numbers.slice(0..2)),
          Local.new(numbers.slice(3..10))
        ]
      when 11
        [
          InternationalCountry.new(numbers.slice(0...1)),
          Area.new(numbers.slice(1..3)),
          Local.new(numbers.slice(4..11))
        ]
      else
        []
    end
    if valid? phone_number_parts
      phone_number_parts.flat_map(&:code).join
    else
      nil
    end
  end

  def self.valid?(phone_number_parts)
    phone_number_parts.all?(&:valid?) && !phone_number_parts.empty?
  end
end

module BookKeeping
  VERSION = 2
end
