Prometheus
-

Prometheus is a time-series database designed to monitor various targets such as servers, databases, and standalone virtual machines. It serves as a comprehensive monitoring solution for a wide range of systems.

Grafana
-

Grafana, a versatile open-source analytical and interactive visualization tool, offers robust charting capabilities, graphical representations, and alert functionalities when connected to supported data sources. Its plugin system allows for extensive customization, enabling users to create intricate monitoring dashboards effortlessly.

Integration of Prometheus with Jenkins
-

To integrate Prometheus with Jenkins, follow these steps:

1.Log in to the Jenkins dashboard.
2.Navigate to "Manage Jenkins" and select "Plugins."
3.In the available plugins section, search for "Prometheus" and install the Prometheus Metrics Plugin.
4.Restart Jenkins to initialize the plugin fully.

Upon installation, the plugin exposes an endpoint where the Prometheus server can fetch data. By default, the endpoint is available at <jenkins-url>/prometheus, for example, 897.145.24:8080/prometheus.

To configure the plugin, go to "Manage Jenkins," then "Configure System," search for Prometheus, and adjust the settings to meet your specific requirements.

Prometheus and Grafana Installation Using Docker
-

For Prometheus:
-
Run the command:

             docker run --name prometheus -d -p 9090:9090 prom/prometheus

For Grafana:
-
Run the command:

             docker run --name grafana -d -p 3000:3000 grafana/grafana

After installing Prometheus and Grafana, configure Prometheus to access Jenkins server:

1.Access the Prometheus container using the command:

              docker exec -it prometheus/prometheuscontainerID /bin/sh

2.Navigate to the configuration directory /etc/prometheus and edit the prometheus.yml file with the appropriate configurations to include the Jenkins server as a target.
3.Verify the configuration and restart the Prometheus container to apply the changes.

Connecting Prometheus to Grafana

1.Log in to the Grafana GUI using the server's public IP address.
2.Add Prometheus as a data source and provide the Prometheus server URL.
3.Save and test the configuration, then create a dashboard in Grafana to visualize the monitoring data effectively.     


**INSTALLATION OF PROMETHEUS USING WGET**

Create an ec2 T2.medium instance

Go to your browser and search for prometheus.

Type prometheus.io/download

Copy ant of the tar files
e.g 
   prometheus.2.51.0rc.0.linux-amd64.tar.gz

Use wget to download it.
unzip the downloaded tar file.
dleete the tar file after unzip

rename the unzip file to prometheus
 
 cd prometheus
 ls

 execute the prometheus executable file to start prometheus.

       ./prometheus & -> & will run the file
                         in the background 

Access prometheus on your browser

      public-ip:9090

**GRAFANA INSTALLATION**

Go to your browser and access

   grafana.com/grafana/download

Run the 3 command you will find for the installation of grafana on ubuntu 

   sudo apt-get install -y adduser libfontconfig1 musl 

   wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.5.2_amd64.deb

   sudo dpkg -i grafana-enterprise_11.5.2_amd64.deb 

After running the 3 commands, run the below command to start grafana.

      sudo /bin/systemctl start grafana-server 

Access garfana

    public-ip:3000

**Exporters configuration**

Access prometheus.io

In the search box, serach for blackbox_exporter 

copy the link to the linux package

user wget to download

  wget blackbox_exporter-0.24.0.linux-amd64.tar.gz

Extract the package after downloading
Delete the tar file
Rename the extracted file to blackbox_exporter

   cd blackbox_exporter
   ls
Execute the blackbox_exporter executable file to start blackbox

    ./blackbox_exporter &

Access blackbox_exporter

     public-ip:9115  


cd to prometheus
vi prometheus.yml

Define the application url that you want to monitor and the blackbox_exporter public-ip:9115.
Edit the below file with your application url and blackbox_exporter public-ip:9115

https://github.com/prometheus/blackbox_exporter

  - job_name: 'blackbox'
    metrics_path: /probe
    params:
      module: [http_2xx]  # Look for a HTTP 200 response.
    static_configs:
      - targets:
        - http://prometheus.io    # Target to probe with http.
        - http://example.com:8080 # Target to probe with http on port 8080.
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9115  # The blackbox exporter's real hostname:port.
  
After doing that, run the below command to get the prometheus process id;

       pgrep prometheus

copy the prometheus PID and kill the process

       kill PID

 This is because we have to restart prometheus
 
        ./prometheus &    -> to restart  


Lonin to grafana, import a dashbord and monitor the application.

**Jenkins monitoring**

Install node_exporter in jenkins.

Access prometheus.io
Search for node_exporter

Copy the link and download it in jenkins using wget.

     wget node_exporter-1.7.0.linux-amd64.tar.gz
After downloading it, unzip the file.
Rename the extracted file to node_exporter.
Delete the tar file

cd node_exporter
ls
Run the executable file

    ./node_exporter

Access node_exporter

     public-ip:9100    

Connect to prometheus server
cd prometheus
ls
vi prometheus.yml

Define node_exporter and jenkins

  - job_name: "node-exporter"
    static_configs:
      - targets: ['34.207.165.62:9100']

  - job_name: "jenkins"
    metrics_path: /prometheus
    static_configs:
      - targets: ['34.207.165.62:8080']

After editing the file
run;
     pgrep prometheus --> process ID

Copy the process ID and kill the process

     kill PID

Restart prometheus

    ./prometheus &     

Verify on prometheus GUI to make sure all the nodes are up and running

Create a new Dashboard for node exporter to monitor jenkins

