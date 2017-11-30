require 'spec_helper'

describe 'numix_gtk_theme' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      context 'config with defaults' do
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

        it do
          should contain_gnome__gsettings('org.cinnamon.desktop.wm.preferences_theme').with(
            key:    'theme',
            schema: 'org.cinnamon.desktop.wm.preferences',
            user:   'testuser',
            value:  '\'Numix\''
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon.desktop.wm.preferences_theme').that_requires('Package[numix-gtk-theme]') }

        it do
          should contain_gnome__gsettings('org.cinnamon.desktop.interface_gtk-theme').with(
            key:    'gtk-theme',
            schema: 'org.cinnamon.desktop.interface',
            user:   'testuser',
            value:  '\'Numix\''
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon.desktop.interface_gtk-theme').that_requires('Package[numix-gtk-theme]') }

        it do
          should contain_gnome__gsettings('org.cinnamon.theme_name').with(
            key:    'name',
            schema: 'org.cinnamon.theme',
            user:   'testuser',
            value:  '\'Numix-Cinnamon\''
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon.theme_name').that_requires('File[/home/testuser/.themes/Numix-Cinnamon]') }

        it do
          should contain_file('/home/testuser/.config').with(
            ensure: 'directory',
            group:  'testgroup',
            mode:   '0700',
            owner:  'testuser'
          )
        end

        it do
          should contain_file('/home/testuser/.config/gtk-3.0').with(
            ensure: 'directory',
            group:  'testgroup',
            mode:   '0700',
            owner:  'testuser'
          )
        end

        it do
          should contain_file('/home/testuser/.config/gtk-3.0/settings.ini').with(
            ensure: 'file',
            group:  'testgroup',
            mode:   '0664',
            owner:  'testuser',
            source: 'puppet:///modules/numix_gtk_theme/settings.ini'
          )
        end
        it { should contain_file('/home/testuser/.config/gtk-3.0/settings.ini').that_requires('File[/home/testuser/.config]') }
        it { should contain_file('/home/testuser/.config/gtk-3.0/settings.ini').that_requires('File[/home/testuser/.config/gtk-3.0]') }

        it do
          should contain_gnome__gsettings('org.cinnamon.desktop.interface_font-name').with(
            key:    'font-name',
            schema: 'org.cinnamon.desktop.interface',
            user:   'testuser',
            value:  '\'Roboto 9\''
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon.desktop.interface_font-name').that_requires('Package[fonts-roboto]') }

        it do
          should contain_gnome__gsettings('org.nemo.desktop_font').with(
            key:    'font',
            schema: 'org.nemo.desktop',
            user:   'testuser',
            value:  '\'Roboto 10\''
          )
        end
        it { should contain_gnome__gsettings('org.nemo.desktop_font').that_requires('Package[fonts-roboto]') }

        it do
          should contain_gnome__gsettings('org.gnome.desktop.interface_document-font-name').with(
            key:    'document-font-name',
            schema: 'org.gnome.desktop.interface',
            user:   'testuser',
            value:  '\'Roboto 10\''
          )
        end
        it { should contain_gnome__gsettings('org.gnome.desktop.interface_document-font-name').that_requires('Package[fonts-roboto]') }

        it do
          should contain_gnome__gsettings('org.gnome.desktop.interface_monospace-font-name').with(
            key:    'monospace-font-name',
            schema: 'org.gnome.desktop.interface',
            user:   'testuser',
            value:  '\'Monospace 9\''
          )
        end
        it { should contain_gnome__gsettings('org.gnome.desktop.interface_monospace-font-name').that_requires('Package[fonts-roboto]') }

        it do
          should contain_gnome__gsettings('org.cinnamon.desktop.wm.preferences_titlebar-font').with(
            key:    'titlebar-font',
            schema: 'org.cinnamon.desktop.wm.preferences',
            user:   'testuser',
            value:  '\'Roboto Medium 9\''
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon.desktop.wm.preferences_titlebar-font').that_requires('Package[fonts-roboto]') }

        it { should compile.with_all_deps }
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
