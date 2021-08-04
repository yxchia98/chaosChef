powershell_script "CPU Load" do
    code <<-EOS
    cd #{ENV['HOME']}
    pwd
    C:\\Users\\Administrator\\jdk-11.0.11+9-jre\\bin\\java.exe -XX:MaxRAMPercentage=100 -jar Javoc.jar -cpu 10 50 -seconds
    EOS
end