# encoding: utf-8
require 'spec_helper'

describe 'Punches#index', type: :feature do
  before { authenticate }

  it 'shows the worked times' do
    create :punch, punched_at: Time.utc(*%w(2013 03 15 08 00))
    create :punch, punched_at: Time.utc(*%w(2013 03 15 16 05))
    create :punch, punched_at: Time.utc(*%w(2013 03 16 08 00))
    create :punch, punched_at: Time.utc(*%w(2013 03 16 17 05))

    visit root_path
    expect(find('#remaining')).to have_content('+ 1 hour, 10 minutes')
    expect(page).to have_content('2013-03-16 (9 hours, 5 minutes)')
    expect(page).to have_content('2013-03-15 (8 hours, 5 minutes)')
  end

  it 'creates a new punch' do
    visit root_path
    select '2013',  from: 'punch_punched_at_1i'
    select 'March', from: 'punch_punched_at_2i'
    select '16',    from: 'punch_punched_at_3i'
    select '10',    from: 'punch_punched_at_4i'
    select '35',    from: 'punch_punched_at_5i'
    click_button 'Punch!'
    expect(page).to have_content('Punched!')

    expect(Punch.first.punched_at).to eql(Time.utc(*%w(2013 03 16 10 35)))
  end

  it 'deletes a punch' do
    create :punch, punched_at: Time.utc(*%w(2013 03 16 08 00))

    visit root_path
    expect { click_link 'Remove' }.to change(Punch, :count).from(1).to(0)
    expect(page).to have_content('Punch deleted!')
  end
end
