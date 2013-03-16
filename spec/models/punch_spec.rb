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
end
