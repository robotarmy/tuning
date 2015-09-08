require 'csv'
require 'json'
require 'fileutils'
ds_dir = ARGV[0] or (puts "expected data-split directory"; exit)
csv_dir = "./data-split-2-csv/"
FileUtils.mkdir_p csv_dir
Dir["#{ds_dir}/**/*.json"].each do |canid_file| 
  File.open(canid_file) do |file|
    filename = (File.basename(canid_file).split(File.extname(canid_file))).first
    filename += ".csv"
    CSV.open(File.join(csv_dir,filename),"wb",:write_headers => true, :headers => ["TIMESTAMP","BYTE0","BYTE1","BYTE2","BYTE3","BYTE4","BYTE5","BYTE6","BYTE7"]) do |f|
      file.each do | line|
       packet = JSON.parse(line)["packet"]
        timestamp = packet['timestamp']
        payload = packet['payload']
        byteload = payload.collect do |str_byte|
          str_byte.to_i(16)
        end
        f << ([timestamp,byteload].flatten)
      end
    end
  end
end
