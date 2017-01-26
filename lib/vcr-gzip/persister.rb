require 'zlib'

module Vcr
  module Gzip
    module Persister
      extend VCR::Cassette::Persisters::FileSystem
      extend self

      def storage_location
        @storage_location or
        VCR.configuration.cassette_library_dir or
        raise "Vcr::Gzip::Persister.storage_location is missing. You must set either set VCR.configuration.cassette_library_dir or Vcr::Gzip::Persister.storage_location"
      end

      def [](file_name)
        path = absolute_path_to_file(file_name)
        return nil unless File.exist?(path)
        file = File.open(path)
        gzip_reader = Zlib::GzipReader.new(file)
        content = gzip_reader.read
        gzip_reader.close
        content
      end
      
      def []=(file_name, content)
        path = absolute_path_to_file(file_name)
        directory = File.dirname(path)
        FileUtils.mkdir_p(directory) unless File.exist?(directory)
        Zlib::GzipWriter.open(path) do |gz|
          gz.write(content)
        end
      end

      def absolute_path_to_file(file_name)
        path = super
        path << ".gz" unless path.nil?
        path
      end
    end
  end
end