
module DSP
  module API
    class AdsInfoSync
      @@target_url = "#{DSP::ADX_URL}/location/list"
      class << self
        #date format YYYY-MM-DD
        def download(date = '')
          body = {date: date}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end
      end
    end
  end
end
