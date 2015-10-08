require 'spec_helper'


describe ::DSP::API::UploadAdsInfo do
  before :all do
    auth = @auth
  end

  context '#upload' do
    it 'upload ads info and return ret_code == 0 if success' do
    	res = ::DSP::API::UploadAdsInfo.upload(file_url = 'http://dsp.hogic.cn/Public/Uploads/201508/55e00f321ba3c.flv')
    	expect(res["ret_code"]).to eq 0
    end
  end
end
