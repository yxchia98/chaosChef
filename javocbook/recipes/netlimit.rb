bagitem = data_bag_item('javoc_data_bag', 'netlimit')
validator = data_bag_item('javoc_data_bag', 'validator')
bagitem['utilization_level'].each do |n|
	if platform?('redhat')
		execute "Network bandwidth throttling at #{n}MB/s for #{bagitem['duration'].at(0)}mins (redhat)" do
			command <<-EOS
			cd #{ENV['HOME']}
			#{bagitem['jrepath_linux']} #{bagitem['jvm_parameters']} Javoc.jar #{"-" + bagitem['type']} #{bagitem['duration'].at(0)} #{n} #{validator['validate_service_linux'] == "" ? "" : "-service " + validator['validate_service_linux']} #{validator['validate_url'] == "" ? "" : "-url " + validator['validate_url']} -seconds
			EOS
		end
		log "after test log" do
			message "Finished executing Network bandwidth throttling at #{n}MB/s for #{bagitem['duration'].at(0)}mins"
			level :info
		end
		chef_sleep 'pause inbetween experiments' do
			seconds 10
			action :sleep
		end
	elsif platform?('windows')
		powershell_script "Network bandwidth throttling at #{n}MB/s for #{bagitem['duration'].at(0)}mins (windows)" do
			code <<-EOS
			cd #{ENV['HOME']}
			#{bagitem['jrepath_windows']} #{bagitem['jvm_parameters']} Javoc.jar #{"-" + bagitem['type']} #{bagitem['duration'].at(0)} #{n} #{validator['validate_service_windows'] == "" ? "" : "-service " + validator['validate_service_windows']} #{validator['validate_url'] == "" ? "" : "-url " + validator['validate_url']} -seconds
			EOS
		end
		log "after test log" do
			message "Finished executing Network bandwidth throttling at #{n}MB/s for #{bagitem['duration'].at(0)}mins"
			level :info
		end
		chef_sleep 'pause inbetween experiments' do
			seconds 10
			action :sleep
		end
	else

	end
end