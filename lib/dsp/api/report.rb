
module DSP
  module API
    class Report
      @@target_url = "#{DSP::ADX_URL}/order/report"
      class << self
        #date format YYYY-MM-DD
        def download(start_date = '', end_date = '')
          raise '请输入开始日期和结束日期！！格式：YYYY-MM-DD， 相差在7天之内' if start_date.empty? or end_date.empty?
          body = {start_date: start_date, end_date: end_date}.merge(DSP::AUTH)
          req = HTTParty.post(@@target_url, body: body).body
          JSON.parse(req)
        end
      end
    end
  end
end
