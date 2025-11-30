# Using Podman instead of Docker

On Linux, it is a legit alternative, to use Podman, instead of Docker. I tried it out (with Fedora Workstation 42), and experienced the following differences:

- obviously all the commands should start with `podman` instead of `docker` (unless you do some aliasing)
- instead of `docker compose` or `docker-compose` you should use `podman-compose`
- file mounting for cases where the container is rootless, you may need to add `:Z` postfix to the mounting configuration, see https://docs.docker.com/engine/storage/bind-mounts/#configure-the-selinux-label
- for `kind` to work, you must run the following command before using `kind` (otherwise it will try to use `docker`): `export KIND_EXPERIMENTAL_PROVIDER=podman`
- for Kind's Ingress to work, you must do the following steps
  - add to `/etc/modules-load.d/iptables.conf` (as sudo) this (see https://kind.sigs.k8s.io/docs/user/rootless/#host-requirements):

  ```
  ip6_tables
  ip6table_nat
  ip_tables
  iptable_nat
  ```

  - create / add to `/etc/containers/containers.conf` (as sudo) the following:

  ```
  [containers]
  pids_limit = 0
  ```
  - after these, the Ingresses' creation may be slow, but they seem to be working
