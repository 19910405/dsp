
module DSP
  module API
    class UploadAdsInfo
      @@target_url = "#{DSP::ADX_URL}/order/sync"
      class << self
        def upload(file_url = '', dsp_order_id = Time.now.to_i)
          order_info = [{
                          "dsp_order_id"=> "#{dsp_order_id}",
                          "client_name"=> "浩趣互动",
                          "file_info"=> [{
                          "file_url"=> "#{file_url}" 
                          }],
                          "targeting_url"=> "http://#{URI(file_url).host}" ,
                        "monitor_url"=> []
                      }].to_json
          body = {order_info: order_info}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        # def uploads()

        # end
      end
    end
  end
end
