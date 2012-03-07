define :postgresql_database, :action => :create, :owner => "postgres" do
  include_recipe "postgresql::server"

  case params[:action]
  when :create
    if params[:template]
      template = "-T #{params[:template]}"
    end

    execute "createdb #{template} #{params[:name]}" do
      user "postgres"
      not_if "psql -f /dev/null #{params[:name]}", :user => "postgres"
    end

    execute "psql -c 'ALTER DATABASE #{params[:name]} OWNER TO #{params[:owner]}'" do
      user "postgres"
    end

    if params[:flags]
      params[:flags].each do |k,v|
        execute "psql -c \"UPDATE pg_catalog.pg_database SET #{k} = '#{v}' WHERE datname = '#{params[:name]}'\" #{params[:name]}" do
          user "postgres"
        end
      end
    end

    languages = params[:languages] || []
    languages = [ *languages ]
    languages << "plpgsql"

    languages.uniq.each do |language|
      execute "createlang #{language} #{params[:name]}" do
        user "postgres"
        not_if "psql -c 'SELECT lanname FROM pg_catalog.pg_language' #{params[:name]} | grep '^ #{language}$'", :user => "postgres"
      end
    end

  when :drop
    execute "psql -c 'DROP DATABASE IF EXISTS #{params[:name]}'" do
      user "postgres"
    end
  end
end
