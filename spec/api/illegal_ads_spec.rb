require 'spec_helper'


describe ::DSP::API::IllegalAds do
  before :all do
    auth = @auth
  end

  context '#download' do
    it 'download illegal ads and return ret_code == 0 if success' do
    	res = ::DSP::API::IllegalAds.download
    	expect(res["ret_code"]).to eq 0
    end
  end
end
