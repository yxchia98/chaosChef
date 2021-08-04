bagitem = data_bag_item('javoc_data_bag', 'cpu')
bagitem['duration'].each do |n|
	if platform?('redhat')
		execute "CPU Load for at level 1 for #{n}mins (redhat)" do
			command <<-EOS
			cd #{ENV['HOME']}
			#{bagitem['jrepath_linux']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{n} #{bagitem['utilization_level'].at(2)} -seconds
			EOS
		end
		log "inbetween tests" do
			message "Finished executing CPU Load at level 1 for #{n}mins"
			level :info
		end
		chef_sleep 'pause inbetween experiments' do
			seconds 10
			action :sleep
		end
	elsif platform?('windows')
		execute "CPU Load for at level 1 for #{n}mins (windows)" do
			command <<-EOS
			cd #{ENV['HOME']}
			#{bagitem['jrepath_windows']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{n} #{bagitem['utilization_level'].at(2)} -seconds
			EOS
		end
		log "inbetween tests" do
			message "Finished executing CPU Load at level 1 for #{n}mins"
			level :info
		end
		chef_sleep 'pause inbetween experiments' do
			seconds 10
			action :sleep
		end
	else

	end
end