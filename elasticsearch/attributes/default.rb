default[:elasticsearch][:cluster_name]            = "default"
default[:elasticsearch][:home_dir]                = "/var/tmp/elasticsearch"
default[:elasticsearch][:conf_dir]                = "/etc/elasticsearch"

default[:elasticsearch][:version]                 = "0.18.5"
default[:elasticsearch][:release_url]             = "https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-:version:.tar.gz"
