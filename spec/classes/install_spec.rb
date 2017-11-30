require 'spec_helper'

describe 'numix_gtk_theme' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      context 'install with defaults' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end
        let :params do
          {
            group: 'testgroup',
            user:  'testuser'
          }
        end
        let :pre_condition do
          [
            'group { "testgroup": ensure => present }',
            'user  { "testuser":  ensure => present }'
          ]
        end

        context 'configure the numix ppa' do
          it { should contain_apt__ppa('ppa:numix/ppa') }
        end

        context 'install numix-gtk-theme' do
          it { should contain_package('numix-gtk-theme').with_ensure('latest') }
        end

        context 'install fonts-roboto' do
          it { should contain_package('fonts-roboto').with_ensure('latest') }
        end

        context 'install numix-cinnamon' do
          it do
            should contain_vcsrepo('/tmp/numix-cinnamon').with(
              ensure:   'present',
              provider: 'git',
              source:   'https://github.com/zagortenay333/numix-cinnamon.git'
            )
          end

          it do
            should contain_file('/home/testuser/.themes').with(
              ensure: 'directory',
              group:  'testgroup',
              mode:   '0700',
              owner:  'testuser'
            )
          end

          it do
            should contain_file('/home/testuser/.themes/Numix-Cinnamon').with(
              ensure: 'directory',
              group:  'testgroup',
              mode:   '0700',
              owner:  'testuser',
              recurse: true,
              source: 'file:///tmp/numix-cinnamon/Numix-Cinnamon'
            )
          end

          it { should contain_file('/home/testuser/.themes/Numix-Cinnamon').that_requires('File[/home/testuser/.themes]') }
          it { should contain_file('/home/testuser/.themes/Numix-Cinnamon').that_subscribes_to('Vcsrepo[/tmp/numix-cinnamon]') }
        end

        it { should compile.with_all_deps }
        it { should contain_apt__ppa('ppa:numix/ppa').that_notifies('Class[apt::update]') }
        it { should contain_package('numix-gtk-theme').that_requires('Class[apt::update]') }
      end

      context 'user param not set' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end
        let :params do
          {
            group: 'testgroup'
          }
        end

        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end

      context 'group param not set' do
        let :facts do
          facts.merge(
            desktop: { type: 'cinnamon' }
          )
        end
        let :params do
          {
            user: 'testuser'
          }
        end

        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'group' expects a String value, got Undef/)
        end
      end
    end
  end
end
