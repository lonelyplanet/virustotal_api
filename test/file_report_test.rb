require './test/test_helper'

class VirustotalAPIFileReportTest < Minitest::Test
  def setup
    @sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::FileReport
  end

  def test_report_response
    VCR.use_cassette('report') do
      virustotal_report = VirustotalAPI::FileReport.find(@sha256, @api_key)

      # Make sure that the JSON was parsed
      assert virustotal_report.kind_of?(VirustotalAPI::FileReport)
      assert virustotal_report.report.kind_of?(Hash)
    end
  end

  def test_report_url
    permalink = "https://www.virustotal.com/file/01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b/analysis/1418032127/"
    VCR.use_cassette('report') do
      virustotal_report = VirustotalAPI::FileReport.find(@sha256, @api_key)

      assert virustotal_report.report_url.kind_of?(String)
      assert virustotal_report.report_url, permalink
    end
  end

  def test_params
    VCR.use_cassette('report') do
      virustotal_report = VirustotalAPI::FileReport.find(@sha256, @api_key)

      assert virustotal_report.api_uri.kind_of?(String)
      assert virustotal_report.api_uri, 'https://www.virustotal.com/vtapi/v2/file/report'
    end
  end

  def test_exists?
    VCR.use_cassette('report') do
      virustotal_report = VirustotalAPI::FileReport.find(@sha256, @api_key)

      assert virustotal_report.exists?, true
    end
  end
end
