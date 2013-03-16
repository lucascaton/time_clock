require 'spec_helper'

describe Punch do
  describe 'validations' do
    context 'when there is already a punch at the same time' do
      it 'is invalid' do
        create :punch, punched_at: Time.local(*%w(2013 03 16 08 00))
        new_punch = build :punch, punched_at: Time.local(*%w(2013 03 16 08 00))
        expect(new_punch).to be_invalid
        expect(new_punch.errors[:punched_at]).to eql(['has already been taken'])
      end
    end
  end

  describe 'callbacks' do
    describe 'on creation' do
      it 'removes seconds from punched_at' do
        punch = create :punch, punched_at: Time.local(*%w(2013 03 16 08 00 45))
        expect(punch.punched_at).to eql(Time.local(*%w(2013 03 16 08 00 00)))
      end
    end
  end

  describe 'scopes' do
    describe '.by_date' do
      it 'returns only punches from a given date' do
        punch_1 = create :punch, punched_at: Time.local(*%w(2013 03 15))
        punch_2 = create :punch, punched_at: Time.local(*%w(2013 03 16))

        date = Date.new 2013, 03, 16
        expect(described_class.by_date(date)).to eq([punch_2])
      end
    end

    describe '.ordered' do
      it 'returns punches ordered' do
        punch_1 = create :punch, punched_at: Time.local(*%w(2013 03 16 08 00))
        punch_2 = create :punch, punched_at: Time.local(*%w(2013 03 16 04 00))
        punch_3 = create :punch, punched_at: Time.local(*%w(2013 03 16 06 00))

        expect(described_class.ordered).to eq([punch_1, punch_3, punch_2])
      end
    end
  end

  describe '.worked_time' do
    before do
      create :punch, punched_at: Time.local(*%w(2013 03 15 08 00))
      create :punch, punched_at: Time.local(*%w(2013 03 15 16 05))
      create :punch, punched_at: Time.local(*%w(2013 03 16 08 00))
      create :punch, punched_at: Time.local(*%w(2013 03 16 17 05))
    end

    context 'without a date' do
      it 'returns a string with the worked time' do
        expect(described_class.worked_time).to eql('17 hours, 10 minutes')
      end
    end

    context 'with a date' do
      it 'returns a string with the worked time' do
        date = Date.new 2013, 03, 16
        expect(described_class.worked_time(date)).to eql('9 hours, 5 minutes')
      end
    end
  end

  describe '.worked_time_balance' do
    before do
      create :punch, punched_at: Time.local(*%w(2013 03 15 08 00))
      create :punch, punched_at: Time.local(*%w(2013 03 15 16 05))
      create :punch, punched_at: Time.local(*%w(2013 03 16 08 00))
      create :punch, punched_at: Time.local(*%w(2013 03 16 17 05))
    end

    context 'without a date' do
      it 'returns a string with the worked time balance' do
        expect(described_class.worked_time_balance).to eql('+ 1 hour, 10 minutes')
      end
    end

    context 'with a date' do
      it 'returns a string with the worked time balance' do
        date = Date.new 2013, 03, 16
        expect(described_class.worked_time_balance(date)).to eql('+ 1 hour, 5 minutes')
      end
    end

    context 'with a negative balance' do
      it 'returns a string with the worked time balance' do
        create :punch, punched_at: Time.local(*%w(2013 03 17 08 00))
        create :punch, punched_at: Time.local(*%w(2013 03 17 09 00))

        expect(described_class.worked_time_balance).to eql('- 5 hours, 50 minutes')
      end
    end

    context 'with a perfect balance' do
      it 'returns "OK"' do
        create :punch, punched_at: Time.local(*%w(2013 03 17 08 00))
        create :punch, punched_at: Time.local(*%w(2013 03 17 14 50))

        expect(described_class.worked_time_balance).to eql('OK')
      end
    end
  end
end
