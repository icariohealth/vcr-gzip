describe "Vcr Gzip" do
  it "registers Vcr::Gzip::Persister as a VCR cassette persister" do
    VCR.cassette_persisters[:file_system_gzip].should eq(Vcr::Gzip::Persister)
  end
end