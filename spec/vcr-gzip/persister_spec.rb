require 'spec_helper'

module Vcr
  module Gzip
    describe Persister do
      describe "#[]" do
        it 'gunzips and reads from the given file' do
          file_path = Persister.storage_location + '/foo.txt.gz'
          Zlib::GzipWriter.open(file_path) do |gz|
            gz.write('12345')
          end
          Persister["foo.txt"].should eq("12345")
        end

        it 'handles directories in the given file name' do
          FileUtils.mkdir_p Persister.storage_location + '/a'
          Zlib::GzipWriter.open(Persister.storage_location + '/a/b.gz') do |gz|
            gz.write('1234')
          end
          Persister["a/b"].should eq("1234")
        end

        it 'returns nil if the file does not exist' do
          Persister["non_existant_file"].should be_nil
        end
      end

      describe "#[]=" do
        it 'gzips and writes the given file contents to the given file name' do
          file_path = Persister.storage_location + '/foo.txt.gz'
          File.exist?(file_path).should be_false
          Persister["foo.txt"] = "bar"
          Zlib::GzipReader.open(file_path) { |gz| gz.read.should eq("bar") }
        end

        it 'creates any needed intermediary directories' do
          File.exist?(Persister.storage_location + '/a').should be_false
          Persister["a/b"] = "bar"
          file_path = Persister.storage_location + '/a/b.gz'
          Zlib::GzipReader.open(file_path) { |gz| gz.read.should eq("bar") }
        end
      end

      describe "#storage_location" do
        before do
          @previous_location = Persister.storage_location
          @previous_default_location = VCR.configuration.cassette_library_dir
        end

        after do
          Persister.storage_location = @previous_location
          VCR.configuration.cassette_library_dir = @previous_default_location
        end

        it "returns VCR.configuration.cassette_library_dir by default" do
          default_location = @previous_default_location + '/default_location'
          VCR::Cassette::Persisters::FileSystem.storage_location = default_location
          Persister.storage_location.should == default_location
        end

        it "allows overwriting the default location" do
          location = @previous_default_location + '/overwritten_location'
          Persister.storage_location = location
          Persister.storage_location.should == location
        end

        it "raises an exception if no location is defined and default is not present" do
          VCR::Cassette::Persisters::FileSystem.storage_location = nil
          Persister.storage_location = nil
          expect {
            Persister.storage_location
          }.to raise_error(/Vcr::Gzip::Persister.storage_location is missing./)
        end
      end

      describe "#absolute_path_to_file" do
        it "returns the absolute path to file relative to the storage location with .gz extension" do
          expected = File.join(Persister.storage_location, "bar/bazz.json.gz")
          Persister.absolute_path_to_file("bar/bazz.json").should eq(expected)
        end

        it "sanitizes the file name" do
          expected = File.join(Persister.storage_location, "_t_i-t_1_2_f_n.json.gz")
          Persister.absolute_path_to_file("\nt \t!  i-t_1.2_f n.json").should eq(expected)

          expected = File.join(Persister.storage_location, "a_1/b.gz")
          Persister.absolute_path_to_file("a 1/b").should eq(expected)
        end
      end
    end
  end
end