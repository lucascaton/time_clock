class TimeConverter
  def initialize(seconds)
    @seconds = seconds
  end

  # Code adapted from:
  # http://stufftohelpyouout.blogspot.com.br/2010/02/seconds-to-days-minutes-hours-seconds.html
  def to_time
    return '-' if @seconds.zero?

    days    = @seconds / 86400
    hours   = (@seconds / 3600) - (days * 24)
    minutes = (@seconds / 60) - (hours * 60) - (days * 1440)
    seconds = @seconds % 60

    display, display_concat = '', ''

    if days > 0
      display = display + display_concat + "#{days} day#{days == 1 ? '' : 's'}"
      display_concat = ', '
    end

    if hours > 0
      display = display + display_concat + "#{hours} hour#{hours == 1 ? '' : 's'}"
      display_concat = ', '
    end

    if minutes > 0
      display = display + display_concat + "#{minutes} minute#{minutes == 1 ? '' : 's'}"
      display_concat = ', '
    end

    if seconds > 0
      display = display + display_concat + "#{seconds} second#{seconds == 1 ? '' : 's'}"
    end

    display
  end
end
