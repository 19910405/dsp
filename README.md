
腾讯DSPruby接口
======

> [sudo] gem install dsp

账号
----

* 设置mapping url【set_mapping_url】
 `::DSP::API::Account.set_mapping_url('http://www.baidu.com')`

* 设置bid url【set_bid_url】

* 设置win notice url【set_win_notice_url】

* 设置qps【set_qps】 `::DSP::API::Account.set_qps('http://www.baidu.com')`

* 设置no cm response【set_no_cm_response】 `::DSP::API::Account.set_no_cm_response(true)`

* 设置use tuserinfo【set_use_tuserinfo】 `::DSP::API::Account.set_use_tuserinfo(true)`

广告信息同步
----

`::DSP::API::AdsInfoSync.download`

广告状态
----

`::DSP::API::AdsStatus.download(广告ID)`

非法广告
----

`::DSP::API::IllegalAds.download(date = "YYYY-MM-DD")`

报表
----

`::DSP::API::Report.download('开始日期2015-10-01', '结束日期2015-10-06')`
报表下载， 开始日期和结束日期相差不超过7天

上传广告信息
----

`::DSP::API::UploadAdsInfo.upload('广告url', 广告id)`
example: 
`::DSP::API::UploadAdsInfo.upload('http://dsp.hogic.cn/Public/Uploads/201508/55e00f321ba3c.flv', 123)`

