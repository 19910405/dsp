require 'spec_helper'


describe ::DSP::API::AdsStatus do
  before :all do
    auth = @auth
  end

  context '#download' do
    it 'download ads status and return ret_code == 0 if success' do
    	res = ::DSP::API::AdsStatus.download('123')
    	expect(res["ret_code"]).to eq 0
    end
  end
end
