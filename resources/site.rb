actions :create, :delete

default_action :create

attribute :siteid     , :kind_of => String, :regex =>  /.*/, :default => nil
attribute :sitename   , :kind_of => String, :regex =>  /.*/, :default => nil
attribute :docroot    , :kind_of => String, :regex =>  /.*/, :default => nil
attribute :siteapps   , :kind_of => Array, :regex =>  /.*/, :default => []
attribute :sitealiases, :kind_of => Array, :regex =>  /.*/, :default => []
attribute :listen     , :kind_of => String, :regex => /.*/, :default => '80'
attribute :enabled    , :kind_of => [ TrueClass, FalseClass ], :default => false
