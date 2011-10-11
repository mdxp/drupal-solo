#
# Cookbook Name:: drupal
# Recipe:: php52
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  components ["lenny", "all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  action :add
end

prefs = <<-EOH
Package: libapache2-mod-php5
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php-pear
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-cli
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-common
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-dev
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-curl
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-gd
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: php5-mysql
Pin: origin packages.dotdeb.org
Pin-Priority: 800

Package: *
Pin: origin packages.dotdeb.org
Pin-Priority: 100
EOH

file "/etc/apt/preferences.d/dotdeb" do
  content prefs
end

package "mysql-common"

remote_file "/usr/local/src/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb" do
  source "http://ftp.us.debian.org/debian/pool/main/m/mysql-dfsg-5.0/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb"
  not_if { File.exists?("/usr/local/src/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb")}
end

dpkg_package "libmysqlclient15off" do
  source "/usr/local/src/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb"
  not_if "dpkg -s libmysqlclient15off | grep 'Version: 5.0.51a-24+lenny5'"
  #options "--force-architecture"
end
