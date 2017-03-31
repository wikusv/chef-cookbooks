node[:deploy].each do |app_name, deploy|
  
  apt_package 'nodejs' do
    action :install
  end

  apt_package 'npm' do
    action :install
  end


  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH

    add-apt-repository ppa:ondrej/php
    apt-get update
    apt-get purge php5-common # remove and purge old PHP 5.x packages
    apt-get update
    apt-get install libapache2-mod-php5.6

    curl -s https://getcomposer.org/installer | php
    composer global require "fxp/composer-asset-plugin:~1.2"
    php composer.phar install --prefer-dist
    EOH
  end
end