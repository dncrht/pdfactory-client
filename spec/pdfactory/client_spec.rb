RSpec.describe PDFactory::Client do
  it "has a version number" do
    expect(PDFactory::VERSION).not_to be nil
  end

  describe '.initialize' do
    let(:url) { 'http://domain.tld' }
    let(:user) { 'user' }
    let(:password) { 'password' }

    it 'requires a URL' do
      expect { described_class.new(url: nil) }.to raise_exception(PDFactory::Client::ArgumentError)
    end

    it 'allows both user and password blank for open server' do
      expect { described_class.new(url: nil, user: '', password: nil) }.to raise_exception(PDFactory::Client::ArgumentError)
    end

    it 'requires a password if user is set' do
      expect { described_class.new(url: url, user: nil, password: password) }.to raise_exception(PDFactory::Client::ArgumentError)
    end

    it 'requires a user if password is set' do
      expect { described_class.new(url: url, user: user, password: nil) }.to raise_exception(PDFactory::Client::ArgumentError)
    end
  end

  describe '#html2pdf' do
    let(:path_to_expected_file) { 'spec/fixtures/expected.pdf' }
    let(:path_to_test_file) { 'tmp/test.pdf' }

    it 'requires a user if password is set' do
      FileUtils.rm(path_to_test_file) if File.exist?(path_to_test_file)

      VCR.use_cassette('html2pdf') do
        pdf = described_class.new(url: 'http://localhost:5000').html2pdf('<h1>Great!</h1>')
        File.write(path_to_test_file, pdf)
      end

      expect(File.read(path_to_test_file)).to eq File.read(path_to_expected_file)
    end
  end
end
