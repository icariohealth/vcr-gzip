require 'vcr-gzip/version'
require 'vcr'
require 'vcr-gzip/persister'

VCR.configuration.cassette_persisters[:file_system_gzip] = Vcr::Gzip::Persister