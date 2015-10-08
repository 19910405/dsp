
module DSP
  module API
    class AdsStatus
      @@target_url = "#{DSP::ADX_URL}/order/getstatus"
      class << self
        #date format YYYY-MM-DD
        def download(*dsp_order_id_info)
          body = {dsp_order_id_info: dsp_order_id_info.to_s}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end
      end
    end
  end
end
