bagitem = data_bag_item('javoc_data_bag', 'reboot')
if platform?('redhat')
    execute "Reboot current machine (redhat)" do
        command <<-EOS
        cd #{ENV['HOME']}
        #{bagitem['jrepath_linux']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration']}
        EOS
    end
elsif platform?('windows')
    execute "Reboot current machine (windows)" do
        command <<-EOS
        cd #{ENV['HOME']}
        #{bagitem['jrepath_windows']} #{bagitem['jvm_parameters']} Javoc.jar -#{bagitem['type']} #{bagitem['duration']}
        EOS
    end
else

end