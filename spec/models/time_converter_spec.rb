require File.expand_path('../../../app/models/time_converter', __FILE__)

describe TimeConverter do
  describe '#to_time' do
    it 'returns a dash' do
      seconds = 0 # 0 seconds
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('-')
    end

    it 'returns a formatted time' do
      seconds = 1 # 1 second
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('1 second')
    end

    it 'returns a formatted time' do
      seconds = 60 + 2 # 1.minute + 2.seconds
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('1 minute, 2 seconds')
    end

    it 'returns a formatted time' do
      seconds = 3600 + 120 + 3 # 1.hour + 2.minutes + 3.seconds
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('1 hour, 2 minutes, 3 seconds')
    end

    it 'returns a formatted time' do
      seconds = 86_400 + 7200 + 180 + 4 # 1.day + 2.hours + 3.minutes + 4.seconds
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('1 day, 2 hours, 3 minutes, 4 seconds')
    end

    it 'returns a formatted time' do
      seconds = 2_592_000 + 172_800 + 10800 + 240 + 5 # 1.month + 2.days + 3.hours + 4.minutes + 5.seconds
      time_converted = TimeConverter.new(seconds).to_time
      expect(time_converted).to eql('32 days, 3 hours, 4 minutes, 5 seconds')
    end
  end
end
