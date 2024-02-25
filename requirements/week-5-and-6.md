# Video

A video for showing the installation and the checking is available. Below you can see a written version of this 
(including links and other useful items to copy-paste).

Note that the scripts’ locations seen in the video changed from _4-1-setup-tools_ and _4-2-check-tools_ 
to **5-1-setup-tools** and **5-2-check-tools**.

# Requirements
For the fifth week’s exercises the following steps must be done before the start:
* It is required to still have the same hosts file setting as previously
* Delete the previous Kubernetes cluster with: `kind delete cluster`
  * We do this so we have a clean, fresh state
* Create the new cluster the same way as seen previous week (also check it the same way)
* Create a namespace different from the `default`, and set it as a default for the kubectl
  * `kubectl create namespace home`
  * `kubectl config set-context --current --namespace=home`
  * Check with `kubectl get all` - you should get a message, like "No resources found in home namespace"
* Two scripts were provided to run into the cluster - open a terminal in the folder for your platform (under /requirements/scripts/5-1-setup-tools)
  * Has different scripts for [Windows](/requirements/scripts/5-1-setup-tools/windows) and [MacOS/Linux](/requirements/scripts/5-1-setup-tools/macos-linux) - use the appropriate one for your system
  * the `dependencies` must be run only if it was never run before (but running it multiple times do no harm)
  * the `install` one will setup everything needed in our cluster
* Wait a few minutes. The tools will be set up and bind together automatically.

# Checking if everything is fine
* Under /requirements/scripts/5-2-check-tools there are scripts for both [Windows](/requirements/scripts/5-2-check-tools/windows) and [MacOS/Linux](/requirements/scripts/5-2-check-tools/macos-linux) - open a terminal in the folder appropriate for your platform
* The `deploy` script will deploy a test application to the cluster, run it
* Wait about 2 minutes. The `test` script will call the test application, run it
  * Keep trying if it still replies with 503 or 500 error codes. If it is still not good after 5 minutes, please reach out to me.
* see this URL: http://grafana.cubix.localhost:8080/explore
  * first, choose Prometheus and `application_ready_time_seconds` as metric, click `Run query` - you should see a chart and some data below it
  * second, choose Loki and have labels set like this: `instance=webinar` and `app!=postgresql`, click `Run query` - you should see some log rows below
  * finally, click on the last log, there will be an ID-like string, with a Tempo button beside it - click on it - you should see a chart
* Run the `undeploy` script, which will clean up this test application
