require 'spec_helper_acceptance'

describe 'riak2 class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'riak2': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('riak') do
      it { is_expected.to be_installed }
    end

    describe service('riak') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
    describe port(8087) do
      it {
        is_expected.to be_listening
      }
    end
  end
end
