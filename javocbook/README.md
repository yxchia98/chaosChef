<h1>Havoc Chef (Javocbook)</h1>
<h2> Overview </h2>
<p>Chef cookbooks and databags will be utilized to deploy the Java application (Javoc.jar) to the remote nodes, as well as to fully remove Javoc.jar from them. Additionally, the cookbook contains recipes for the automated execution of chaos experiments using Javoc.jar, at different levels (utilization thresholds) as per the use cases.</p>

<h2>Chef Cookbook (javocbook)</h2>
<p>The chef cookbook (javocbook) contains recipes to deploy as well as execute Javoc.jar to nodes connected to the chef infra server, and will be documented in the table below:</p>
<p>Data regarding the Java JRE path, duration, and utilization thresholds (expressed as lvl1/lvl2/lvl3 in recipe names) will be stored in a databag (javoc_data_bag), with each experiment type having their own respective data bag item.</p>

<table>
    <tr>
        <th rowspan="2" colspan="6">Recipe</th><th rowspan="2">Function</th>
        <th colspan="3">Utilization Levels</th>
    </tr>
    <tr>
        <th>lvl1</th>
        <th>lvl2</th>
        <th>lvl3</th>
    </tr>
    <tr>
        <td colspan="6">movefiles.rb</td>
        <td>Move Javoc.jar into the HOME directory</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
    <tr>
        <td colspan="6">removefiles.rb</td>
        <td>Remove Javoc.jar and Clumsy files from the HOME directory</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
    <tr>
        <td>cpu.rb</td>
        <td>mem.rb</td>
        <td>disk.rb</td>
        <td>netlag.rb</td>
        <td>netdrop.rb</td>
        <td>netlimit.rb</td>
        <td>Executes the respective chaos experiments according to their types, at the highest duration specified in the data bag for each utilization level.</td>
    </tr>
    <tr>
        <td colspan="2">cpu-lvl1.rb</td>
        <td colspan="2">cpu-lvl2.rb</td>
        <td colspan="2">cpu-lvl3.rb</td>
        <td>Load CPU according to levels, taking variables from cpu.json data bag item, for 1min/5min/10min with 90seconds delay inbetween.</td>
        <td>50%</td>
        <td>75%</td>
        <td>90%</td>
    </tr>
    <tr>
        <td colspan="2">mem-lvl1.rb</td>
        <td colspan="2">mem-lvl2.rb</td>
        <td colspan="2">mem-lvl3.rb</td>
        <td>Load Memory according to levels, taking variables from mem.json data bag item, for 1min/5min/10min with 90seconds delay inbetween.</td>
        <td>50%</td>
        <td>75%</td>
        <td>90%</td>
    </tr>
    <tr>
        <td colspan="2">disk-lvl1.rb</td>
        <td colspan="2">disk-lvl2.rb</td>
        <td colspan="2">disk-lvl3.rb</td>
        <td>Load Disk according to levels, taking variables from disk.json data bag item, for 1min/5min with 90seconds delay inbetween.</td>
        <td>50%</td>
        <td>75%</td>
        <td>90%</td>
    </tr>
    <tr>
        <td colspan="3">netlag-lvl1.rb</td>
        <td colspan="3">netlag-lvl2.rb</td>
        <td>Delay Network Packets according to levels, taking variables from netlag.json data bag item, for 5mins.</td>
        <td>500ms</td>
        <td>5000ms</td>
        <td>-</td>
    </tr>
    <tr>
        <td colspan="2">netdrop-lvl1.rb</td>
        <td colspan="2">netdrop-lvl2.rb</td>
        <td colspan="2">netdrop-lvl3.rb</td>
        <td>Drop Network packets according to levels, taking variables from netdrop.json data bag item, for 5mins.</td>
        <td>25%</td>
        <td>50%</td>
        <td>75%</td>
    </tr>
    <tr>
        <td colspan="3">netlimit-lvl1.rb</td>
        <td colspan="3">netlimit-lvl2.rb</td>
        <td>Throttle Network Bandwidth according to levels, taking variables from netlimit.json data bag item, for 5mins.</td><td>10MB/s</td>
        <td>5MB/s</td>
        <td>-</td>
    </tr>
    <tr>
        <td colspan="6">reboot.rb</td>
        <td>Reboot node, taking variables from reboot.json data bag item.</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
</table>

<h2>Data bags (javoc_data_bag)</h2>
<p>All chaos experiment recipes are templated in such a way that all variables will be referenced from their respective data bag items. Data bag items are JSON files in key-value pairs, which include durations, utilizations, JRE paths of corresponding experiments.</p>
<p>With the following setup, any changes in the future can be made just by editing the data bag variables, and will be reflected to the recipes and experiments.</p>
<p>Additionally, the validator.json data bag item will contain the services and URLs to verify for steady-state. All chaos experiment recipes will check against the specified URL and service for availibility in 1 minute intervals during the experiments.</p>
<p>The data bag items used will be documented in the table below, with the common properties being:</p>

<p>JVM Parameters: -XX:MaxRAMPercentage=100 -jar <br>
Windows JRE path: C:\Riverbed\Panorama\hedzup\mn\jre\bin\java.exe <br>
Linux JRE path: /opt/riverbed/Panorama/hedzup/mn/jre/bin/java</p>

<table>
    <tr>
        <th rowspan="2">Data bag item<th>
        <th colspan="9">Properties</th>
    </tr>
    <tr>
        <th>Type</th><th colspan="3">Utilization levels</th><th colspan="3">Durations</th><th>ID</th><th>Description</th>
    </tr>
    <tr>
        <td>cpu.json</td><td>cpu</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td>5min</td><td>10min</td><td>cpu</td><td>Variables for loading CPU</td>
    </tr>
    <tr>
        <td>mem.json</td><td>mem</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td>5min</td><td>10min</td><td>mem</td><td>Variables for loading Memory</td>
    </tr>
    <tr>
        <td>disk.json</td><td>disk</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td colspan="2">5min</td><td>disk</td><td>Variables for loading Disk</td>
    </tr>
    <tr>
        <td>netlag.json</td><td>netlag</td><td>500ms</td><td colspan="2">5000ms</td><td colspan="3">5min</td><td>netlag</td><td>Variables for delaying network packets</td>
    </tr>
    <tr>
        <td>netdrop.json</td><td>netdrop</td><td>25%</td><td>50%</td><td>75%</td><td colspan="3">5min</td><td>netdrop</td><td>Variables for dropping network packets</td>
    </tr>
    <tr>
        <td>netlimit.json</td><td>netlimit</td><td>10MB/s</td><td colspan="2">5MB/s</td><td colspan="3">5min</td><td>netlimit</td><td>Variables for Bandwidth Throttling</td>
    </tr>
    <tr>
        <td>reboot.json</td><td>reboot</td><td colspan="3">-</td><td colspan="3">0</td><td>reboot</td><td>Variables for rebooting system</td>
    </tr>
    <tr>
        <td>validator.json</td><td>validator</td><td colspan="6">-</td><td>validator</td><td>Variables for verification of Steady State</td>
    </tr>
</table>

<h2>Upload and execution of Cookbooks, Recipes and Databags</h2>
<h3>Upload Cookbook (javocbook)</h3>
<p>knife cookbook upload javocbook</p>
<h3>Upload Data bag (javoc_data_bag)</h3>
<p>knife data bag create javoc_data_bag<br>
<p>knife data bag from file javoc_data bag cpu.json mem.json disk.json netlag.json netdrop.json netlimit.json reboot.json validator.json</p>
<h3>Executing recipes in node</h3>
<p># Move files into home directory first by executing movefiles recipe <br>
chef-client -l info -o 'recipe[javocbook::movefiles]'</p>
<p># Perform chaos experiments as needed <br>
chef-client -l info -o 'recipe[javocbook::cpu-lvl1]' <br>
chef-client -l info -o 'recipe[javocbook::mem-lvl1]' <br>
...
</p>
<p># Remove files initially created, as well as those created by Javoc.jar<br>
chef-client -l info -o 'recipe[javocbook::removefiles]'</p>

