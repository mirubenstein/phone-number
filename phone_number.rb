class PhoneNumber
  def self.clean(phone_number)
    phone_number.match(/^\+?1?\D*([2-9]\d{2})\D*([2-9]\d{2})\D*(\d{4})\D*$/) do |x|
      "#{x[1]}#{x[2]}#{x[3]}"
    end
  end
end

module BookKeeping
  VERSION = 2
end
