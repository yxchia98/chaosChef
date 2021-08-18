<h2>Data bags (javoc_data_bag)</h2>
<p>All chaos experiment recipes are templated in such a way that all variables will be referenced from their respective data bag items. Data bag items are JSON files in key-value pairs, which include durations, utilizations, JRE paths of corresponding experiments.</p>
<p>With the following setup, any changes in the future can be made just by editing the data bag variables, and will be reflected to the recipes and experiments.</p>
<p>Additionally, the validator.json data bag item will contain the services and URLs to verify for steady-state. All chaos experiment recipes will check against the specified URL and service for availibility in 1 minute intervals during the experiments.</p>
<p>The data bag items used will be documented in the table below, with the common properties being:</p>

<p>JVM Parameters: -XX:MaxRAMPercentage=100 -jar <br>
Windows JRE path: &l tredacted &gt <br>
Linux JRE path: &lt redacted &gt</p>

<table>
    <tr><th rowspan="2">Data bag item<th><th colspan="9">Properties</th></tr>
    <tr><th>Type</th><th colspan="3">Utilization levels</th><th colspan="3">Durations</th><th>ID</th><th>Description</th></tr>
    <tr><td>cpu.json</td><td>cpu</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td>5min</td><td>10min</td><td>cpu</td><td>Variables for loading CPU</td></tr>
    <tr><td>mem.json</td><td>mem</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td>5min</td><td>10min</td><td>mem</td><td>Variables for loading Memory</td></tr>
    <tr><td>disk.json</td><td>disk</td><td>50%</td><td>75%</td><td>90%</td><td>1min</td><td colspan="2">5min</td><td>disk</td><td>Variables for loading Disk</td></tr>
    <tr><td>netlag.json</td><td>netlag</td><td>500ms</td><td colspan="2">5000ms</td><td colspan="3">5min</td><td>netlag</td><td>Variables for delaying network packets</td></tr>
    <tr><td>netdrop.json</td><td>netdrop</td><td>25%</td><td>50%</td><td>75%</td><td colspan="3">5min</td><td>netdrop</td><td>Variables for dropping network packets</td></tr>
    <tr><td>netlimit.json</td><td>netlimit</td><td>10MB/s</td><td colspan="2">5MB/s</td><td colspan="3">5min</td><td>netlimit</td><td>Variables for Bandwidth Throttling</td></tr>
    <tr><td>reboot.json</td><td>reboot</td><td colspan="3">-</td><td colspan="3">0</td><td>reboot</td><td>Variables for rebooting system</td></tr>
    <tr><td>validator.json</td><td>validator</td><td colspan="6">-</td><td>validator</td><td>Variables for verification of Steady State</td></tr>
</table>

<h2>Uploading of data bag (javoc_data_bag)</h2>
<p>knife data bag create javoc_data_bag<br>
<p>knife data bag from file javoc_data bag cpu.json mem.json disk.json netlag.json netdrop.json netlimit.json reboot.json validator.json</p>
