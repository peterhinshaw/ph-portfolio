require 'find'
require 'pathname'

class Findfile 

  def self.findfiles(find_start, extensions)
#    puts extensions
    dirpath = Hash.new
    Find.find(find_start) do |path|
      if FileTest.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune       # Don't look any further into this directory.
        else
          next
        end
      else
        if (File.split(path)[1] =~ /jpeg$|jpg$|JPG$|JPEG$|gif$|GIF$/)
          dirpath[File.split(path)[0]] = File.split(path)[0]
          Find.prune
        end
      end
    end
    return dirpath
  end
end
