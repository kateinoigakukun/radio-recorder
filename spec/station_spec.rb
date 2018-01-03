require 'spec_helper'

describe Station::AGRadio::Schedule do
  let(:st) {
    schedule_yml = Station::AGRadio.schedule_list[0]
    Station::AGRadio::Schedule.new schedule_yml
  }

  describe 'video?' do
    it { expect(st.video).to be true }
  end
end
