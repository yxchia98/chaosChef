bagitem = data_bag_item('javoc_data_bag', 'mem')
if platform?('redhat')
	execute "Memory Load level 3 for 10min (redhat)" do
		command <<-EOS
        cd #{ENV['HOME']}
		#{bagitem['jrepath_linux']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration'].at(2)} #{bagitem['utilization_level'].at(2)}
		EOS
	end
else
	execute "Memory Load level 3 for 10min (windows)" do
		command <<-EOS
        cd #{ENV['HOME']}
		#{bagitem['jrepath_windows']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration'].at(2)} #{bagitem['utilization_level'].at(2)}
		EOS
	end
end