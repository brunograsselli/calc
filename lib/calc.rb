class Calculator
  PATH = "/home/bruno/projects/calc/"

  def initialize(time_as_string)
    if time_as_string.nil?
      time_as_string = File.read(PATH + 'data/time').chomp
    else
      save! time_as_string
    end
    @hours, @minutes = time_as_string.scan(/(\d{2}):(\d{2})/).flatten
    @initial_time = Time.mktime 2011, 01, 01, @hours.to_i, @minutes.to_i, 00
    calc!
  end
  
  def to_s
    "#{@initial_time.strftime "%H:%M"}: #{@minimum_time.strftime "%H:%M"} - #{@time.strftime "%H:%M"} - #{@maximum_time.strftime "%H:%M"}"
  end

  private

  def save!(time)
    File.open(PATH + 'data/time', 'w') {|f| f.puts time}
  end

  def calc!
    @time = @initial_time + 35280
    @minimum_time = @time - 900
    @maximum_time = @time + 900
    nil
  end
end
