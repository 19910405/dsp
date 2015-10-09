
require 'httparty'
require 'json'

module DSP
  autoload :API , 'dsp/api'
  autoload :BID , 'dsp/bid'

  VERSION='0.0.2'

  AUTH = {dsp_id: 190, token: '73553e669b7270a4934706f76a99ad36'}
  ADX_URL = 'http://opentest.adx.qq.com'
end
