VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "db" do |app|
    app.vm.provider "docker" do |d|
      d.image = "postgres:9.3"
      d.name = "broad_db"
      d.ports  = ['5432:5432']
      d.vagrant_vagrantfile = "../Vagrantfile"
    end
  end

  config.vm.define "redis" do |v|
    v.vm.provider "docker" do |d|
      d.image = "redis"
      d.name = 'broad_redis'
      d.ports = ["6379:6379"]
      d.vagrant_vagrantfile = "../Vagrantfile"
    end
  end
end
