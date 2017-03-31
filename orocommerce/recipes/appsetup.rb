node[:deploy].each do |app_name, deploy|
  script "install_node_js" do
    interpreter "bash"
    user "root"
    code <<-EOH
     apt-get install nodejs 
     apt-get install npm 
     EOH
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