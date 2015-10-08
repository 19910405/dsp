
module DSP
  module API
    class Account
      @@target_url = "#{DSP::ADX_URL}/config/set"

      class << self
        def set_mapping_url(url)
          body = {mapping_url: url}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        def set_bid_url(url)
          body = {bid_url: url}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        def set_win_notice_url(url)
          body = {win_notice_url: url}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        def set_qps(qps)
          body = {qps: qps}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        def set_no_cm_response(bool = true)
          body = {no_cm_response: bool == true ? 'Y' : 'N'}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end

        def set_use_tuserinfo(bool = true)
          body = {use_tuserinfo: bool == true ? 'Y' : 'N'}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end
      end
    end
  end
end
