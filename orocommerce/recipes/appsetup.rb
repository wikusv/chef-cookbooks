node[:deploy].each do |app_name, deploy|
  apt_package ['nodejs','npm'] do
    action :install
  end

  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    composer global require "fxp/composer-asset-plugin:~1.2"
    php composer.phar install --prefer-dist
    EOH
  end
end