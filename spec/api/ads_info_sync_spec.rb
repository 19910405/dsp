require 'spec_helper'


describe ::DSP::API::AdsInfoSync do
  before :all do
    auth = @auth
  end

  context '#download' do
    it 'download ads info and return ret_code == 0 if success' do
    	res = ::DSP::API::AdsInfoSync.download()
    	expect(res["ret_code"]).to eq 0
    end
  end
end
