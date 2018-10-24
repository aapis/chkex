module Chkex
  class FileHandler
    def self.read_list(file_path)
      # file_path is actually a URL, not a file, don't try to open it
      return file_path unless File.file?(file_path)

      raise Chkex::FileNotFound unless File.exist?(file_path)

      File.read(file_path).split("\n")
    end
  end
end