bagitem = data_bag_item('javoc_data_bag', 'mem')
if platform?('redhat')
	execute "Memory Load level 2 for 5min (redhat)" do
		command <<-EOS
        cd #{ENV['HOME']}
		#{bagitem['jrepath_linux']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration'].at(1)} #{bagitem['utilization_level'].at(1)}
		EOS
	end
else
	execute "Memory Load level 2 for 5min (windows)" do
		command <<-EOS
        cd #{ENV['HOME']}
		#{bagitem['jrepath_windows']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration'].at(1)} #{bagitem['utilization_level'].at(1)}
		EOS
	end
end