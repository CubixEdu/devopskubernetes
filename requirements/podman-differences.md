# Using Podman instead of Docker

On Linux, it is a legit alternative, to use Podman, instead of Docker. I tried it out (with Fedora Linux 44 KDE Plasma Desktop Edition), and experienced the following differences:

- obviously all the commands should start with `podman` instead of `docker` (unless you do some aliasing)
- instead of `docker compose` or `docker-compose` you should use `podman-compose`
- file mounting for cases where the container is rootless, you may need to add `:Z` postfix to the mounting configuration, see https://docs.docker.com/engine/storage/bind-mounts/#configure-the-selinux-label
- for Kind's Ingress to work, you must do the following steps (see https://kind.sigs.k8s.io/docs/user/rootless/#host-requirements)
  - add to `/etc/modules-load.d/iptables.conf` (as sudo) this:

  ```
  ip6_tables
  ip6table_nat
  ip_tables
  iptable_nat
  ```

  - create / add to `/etc/containers/containers.conf` (as sudo) the following:

  ```
  [containers]
  pids_limit = 65536
  ```

  - create a file `/etc/sysctl.d/10-inotify-increase.conf` (as sudo) the following:

  ```
  fs.inotify.max_user_watches = 524288
  fs.inotify.max_user_instances = 512
  ```

  - Restart what needs restarting:

  ```
  sudo systemctl restart systemd-modules-load.service
  sudo sysctl --system
  ```

  - after these try the cluster cration - the Ingresses' creation may be slow, but they seem to be working
