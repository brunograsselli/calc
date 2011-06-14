require "rubygems"
require "redis"

class Calculator
  REDIS_KEY = "calc:start_time"

  def initialize(time_as_string)
    @redis = Redis.new

    if time_as_string.nil?
      time_as_string = @redis.get(REDIS_KEY) || "09:00"
    else
      save! time_as_string
    end
    @hours, @minutes = time_as_string.scan(/(\d{2}):(\d{2})/).flatten
    @initial_time = Time.mktime 2011, 01, 01, @hours.to_i, @minutes.to_i, 00
    calc!
  end
  
  def to_s
    line_bar = "+------------------------------------+"
    header   = "| Chegada | Minimo | Normal | Maximo |"
    mid_bar  = "+---------+--------+--------+--------+"

    init_time_str = @initial_time.strftime "%H:%M"
    min_time_str = @minimum_time.strftime "%H:%M"
    normal_time_str = @time.strftime "%H:%M"
    max_time_str = @maximum_time.strftime "%H:%M"
    time_line = "| #{init_time_str}   | #{min_time_str}  | #{normal_time_str}  | #{max_time_str}  |"

    "#{line_bar}\n#{header}\n#{mid_bar}\n#{time_line}\n#{line_bar}\n"
  end

  private

  def save!(time)
    @redis.set REDIS_KEY, time
  end

  def calc!
    @time = @initial_time + 35280
    @minimum_time = @time - 900
    @maximum_time = @time + 900
    nil
  end
end
