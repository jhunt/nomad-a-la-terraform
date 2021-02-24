nomad-atop-linode
=================

This repository contains my research into running nomad clusters
atop Linode instances.  It may be incomplete, incoherent,
inchoate, or any other not-at-all-flattering 'in-' word.

The Quickest Start
------------------

tl;dr:

    $ vim my.tfvars

    $ terraform apply -var-file=my.tfvars
      ... then say 'yes' ...

    $ ssh root@<second-ip>
    root@node1 # nomad server join <first-ip>

    $ ssh root@<third-ip>
    root@node2 # nomad server join <first-ip>

Then (I think) you have a 3-node nomad cluster.  From one of the
nodes you can deploy redis:

    $ ssh root@<a-random-node>
    root@node2 # nomad job init example.nomad
    root@node2 # nomad run job example.nomad



Some Useful Commands
--------------------

See the control plane member nodes:

    root@nodeX # nomad server list

See this node's configuration, drivers, etc.:

    root@nodeX # nomad node status -self
