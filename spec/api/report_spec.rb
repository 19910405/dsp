require 'spec_helper'


describe ::DSP::API::Report do
  before :all do
    auth = @auth
  end

  context '#download' do
    it 'download reports and return ret_code == 0 if success' do
    	res = ::DSP::API::Report.download('2015-10-01', '2015-10-06')
    	expect(res["ret_code"]).to eq 0
    end
  end
end
