bagitem = data_bag_item('javoc_data_bag', 'testbag')
if platform?('redhat')
	jrepath = bagitem['jrepath_linux']
	execute "testexecution" do
		command <<-EOS
		echo "#{jrepath} #{bagitem['jvm_parameters']}"
		EOS
	end
else
	jrepath = bagitem['jrepath_windows']
	execute "testexecution" do
		command <<-EOS
		echo "#{jrepath} #{bagitem['jvm_parameters']}"
		EOS
	end
end