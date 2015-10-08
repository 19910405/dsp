require 'spec_helper'


describe ::DSP::API::Account do
  before :all do
    auth = @auth
  end

  context '#set_mapping_url' do
    it 'set mapping url and return ret_code == 0 if success' do
    	res = ::DSP::API::Account.set_mapping_url('http://www.baidu.com')
    	expect(res["ret_code"]).to eq 0
    end
  end
end
