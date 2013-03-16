# encoding: utf-8
require 'spec_helper'

describe 'Layout#application', type: :feature do
  before { authenticate }

  it 'has the correct information in initial page' do
    visit root_path
    expect(find('.navbar-fixed-top a.brand')).to have_content('Time Clock')
    expect(page).to have_content("Copyright © #{Date.today.year} Time Clock. This is an open source project.")
  end
end
