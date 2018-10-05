class Calendar

  attr_reader :date

  def initialize(date)
    @date = date
  end
  
  # we need this for generating the calendar in the goals calendar view

  def cal_array
    date_array = Array.new(35, "")
    position = @date.beginning_of_month.wday
    @date.beginning_of_month.upto @date.end_of_month do |next_date|
      date_array[position] = next_date
      position += 1
    end
    date_array
  end

  def cal_go_up
    if @date.month == 12
      month = 1
      year = @date.year + 1
    else
      month = @date.month + 1
      year = @date.year
    end
    "calendar?date=#{@date.day}-#{month}-#{year}"
  end

  def cal_go_down
    if @date.month == 1
      month = 12
      year = @date.year - 1
    else
      month = @date.month - 1
      year = @date.year
    end
    "calendar?date=#{@date.day}-#{month}-#{year}"
  end

end
