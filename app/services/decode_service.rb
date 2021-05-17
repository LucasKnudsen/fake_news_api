module DecodeService 
  def self.attach_image(file, target) 
    image = split_base64(file) 

    decoded_image = Base64.decode64(image[:data]) 
    io = StringIO.new 
    io.puts(decoded_image) 
    io.rewind 
    target.image.attach(io: io, filename: "attachment.#{image[:extension]}") 
  end

  def self.split_base64(string) 
    uri = {} 
    if string =~ /^data:(.*?);(.*?),(.*)$/ 
      uri[:type] = Regexp.last_match(1) 
      uri[:encoder] = Regexp.last_match(2)
      uri[:extension] = Regexp.last_match(1).split('/').last  
      uri[:data] = Regexp.last_match(3) 
    end
    uri 
  end 
end