class DataFile < ActiveRecord::Base
  def self.save(upload)

#    debugger if ENV['RAILS_ENV'] == 'development'

    name =  upload.original_filename.gsub(/ /,'')
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.read) }
    return name
  end
end
