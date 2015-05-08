require 'json'
require 'rest_client'


class Solution < Rhoconnect::Model::Base
  def initialize(source)
       @base = 'http://imagecap.herokuapp.com/solutions'
       super(source)
     end
   
     def query(params=nil)
       rest_result = RestClient.get("#{@base}.json").body
   
     if rest_result.code != 200
       raise Rhoconnect::Model::Exception.new("Error connecting!")
     end
       parsed = JSON.parse(rest_result)
   
       @result={}
       parsed.each do |item|
         @result[item["solution"]["id"].to_s] = item["solution"]
       end if parsed
     end
   
     def create(create_hash)
       res = RestClient.post(@base,:solution => create_hash)
   
       # After create we are redirected to the new record.
       # We need to get the id of that record and return
     # it as part of create so rhoconnect can establish a link
     # from its temporary object on the client to this newly
     # created object on the server
       JSON.parse(
       RestClient.get("#{res.headers[:location]}.json").body
     )["solution"]["id"]
     end
   
     def update(update_hash)
       obj_id = update_hash['id']
       update_hash.delete('id')
       RestClient.put("#{@base}/#{obj_id}",:solution => update_hash)
     end
   
     def delete(delete_hash)
       RestClient.delete("#{@base}/#{delete_hash['id']}")
     end
end