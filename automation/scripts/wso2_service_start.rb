require 'uri'
require 'net/https'

service = ARGV[0]
url = URI("https://10.220.28.108:9443/services/ServiceAdmin.ServiceAdminHttpsSoap11Endpoint")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["soapaction"] = 'urn:startService'
request["content-type"] = 'text/xml'
request["authorization"] = 'Basic YWRtaW46YWRtaW4='
request["cache-control"] = 'no-cache'
#request["postman-token"] = '6dea0615-eeec-d8db-6eaa-b6fb1f58308b'
request.body = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://org.apache.axis2/xsd\">\r\n   <soapenv:Header/>\r\n   <soapenv:Body>\r\n      <xsd:startService>\r\n         <!--Optional:-->\r\n         <xsd:serviceName>#{service}</xsd:serviceName>\r\n      </xsd:startService>\r\n   </soapenv:Body>\r\n</soapenv:Envelope>"

response = http.request(request)
puts response.read_body
