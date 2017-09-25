require 'uri'
require 'net/https'
require 'nokogiri'

def request(page)
url = URI("https://10.220.28.108:9443/services/ServiceAdmin?wsdl")


http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["soapaction"] = 'urn:listServices'
request["content-type"] = 'text/xml'

request.basic_auth 'esb-admin', 'wSo@dm1n#'
#request["authorization"] = 'Basic YWRtaW46YWRtaW4='
request["cache-control"] = 'no-cache'
#request["postman-token"] = '2a723b99-b40d-bdc4-b0d7-c5ae8e64e890'
request.body = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://org.apache.axis2/xsd\">\r\n   <soapenv:Header/>\r\n   <soapenv:Body>\r\n      <xsd:listServices>\r\n         <!--Optional:-->\r\n         <xsd:serviceTypeFilter>ALL</xsd:serviceTypeFilter>\r\n         <!--Optional:-->\r\n         <xsd:serviceSearchString>*</xsd:serviceSearchString>\r\n         <!--Optional:-->\r\n         <xsd:pageNumber>#{page}</xsd:pageNumber>\r\n      </xsd:listServices>\r\n   </soapenv:Body>\r\n</soapenv:Envelope>"

response = http.request(request)
xml_response = response.read_body
return xml_response
end

# Variables to be used on start conditions
f = request(0)
doc = Nokogiri::XML(f)

   def list_services(doc, args=nil)

     doc.xpath("//ax2509:services", "ax2509" => "http://mgt.service.carbon.wso2.org/xsd").each do |service_node|
           #puts "====================================================================================================="
           #puts "Service Name: Status"
           @name =  service_node.xpath("ax2509:name", "ax2509" => "http://mgt.service.carbon.wso2.org/xsd").text
           @status = service_node.xpath("ax2509:active", "ax2509" => "http://mgt.service.carbon.wso2.org/xsd").text
              arg_list = args
              if arg_list == nil
                 puts "====================================================================================================="
                 puts "Service Name: Status"
                 puts @name+": "+@status
                 puts "====================================================================================================="
              else
                 arg_list.each do |item|
                     if item == @name
                        puts "====================================================================================================="
                        puts "Service Name: Status"
                        puts @name+": "+@status
                        puts "====================================================================================================="
                     end
                 end
              end
           #puts "====================================================================================================="
     end
            doc_aux = doc
            @number_of_pages = doc_aux.xpath("//ax2509:numberOfPages", "ax2509" => "http://mgt.service.carbon.wso2.org/xsd").text
            @number_of_pages = @number_of_pages.to_i
            return @number_of_pages
   end

  def list_services_pages(n)
    if n > 1
      for i in 1...n
          aux = request(i)
          aux_doc = Nokogiri::XML(aux)
          list_services(aux_doc)
      end
    end
  end


#######################################################################################################################
n = list_services(doc)
list_services_pages(n)

