# Why Tarsnap?

[Tarsnap](https://www.tarsnap.com) is a cost-effective and secure backup provider. For more information start from the [Tarsnap design detail pages](https://www.tarsnap.com/design.html) and work out if it's the service for you. If it is then go ahead and use this Docker image.

# This Docker Image

Tags correspond in name to the version of the [Tarsnap source](https://github.com/Tarsnap/tarsnap) they're built from.

The source code for this image is on GitHub at [sappho/docker-build-tarsnap](https://github.com/sappho/docker-build-tarsnap). It is distributed under the [MIT license](https://opensource.org/licenses/MIT). Contributions are welcome - please fork and submit pull requests.

[![Build Status](https://travis-ci.org/sappho/docker-build-tarsnap.svg?branch=master)](https://travis-ci.org/sappho/docker-build-tarsnap)

# Creating a Private Key Image

This public Tarsnap image requires a private key to securely communicate with [tarsnap.com](https://www.tarsnap.com). You should create a private Docker image based on this public Tarsnap image and keep your private key in it. This project has a sub-directory named `sample-private-key-image` you can use as a template for this. Create your own project (and store it in a private repository) then run this command to begin creating your private key:

    docker run -ti --name=tarsnapgenkey sappho/tarsnap bash

At the Bash shell prompt type the command:

    tarsnap-keygen --keyfile /root/tarsnap.key \
        --user me@example.com --machine mybox

Replace the `user` parameter with the email address you use to login to your [Tarsnap account](https://www.tarsnap.com/account.html) and `machine` with something personal to you, and note that it does not have to be the hostname of a machine - it can be any meaningful identifier, and it will show up under _Recent activity (one machine)_ on your Tarsnap account. After running this command type `exit` to exit the Bash shell. Then run something like this command:

    docker cp tarsnapgenkey:/root/tarsnap.key \
        /path/to/your/private/docker/project/

This will copy the private key you've just generated into your own Dockerfile project by changing `/path/to/your/private/docker/project/` to the path to your project. Delete the container now with:

    docker rm -f tarsnapgenkey

Finally, build your customised Tarsnap image with something like this:

    docker build -t myname/tarsnap-private /path/to/your/private/docker/project/

From this point on use your image instead of the standard `sappho/tarsnap` image. In the rest of this readme the image tag `myname/tarsnap-private` will be used to refer to your private key image.

Finally, note that you can create as many private keys, in different private images, as you like.

# Creating a Tarsnap Backup Cache

Tarsnap uses a cache to allow it to create efficient backups. The best way to maintain a cache is to create a Docker data volume container from your private key image, like this:

    docker run -ti --name tarsnap_cache myname/tarsnap-private /opt/fix.sh

The `/opt/fix.sh` script will create a valid cache. You can delete the `tarsnap_cache` container at any time and then re-create it with the above command, which will rebuild the cache from all of the backups that you have on Tarsnap. This is probably the easiest way to recover the cache if it's corrupted. Otherwise, once you've created the cache container you should not normally delete it.

# Creating a Backup

To create a backup of the data in a data volume container use a command like this:

    docker run -ti --rm=true \
        --volumes-from tarsnap_cache --volumes-from other_container:ro \
        --env IMAGE_PREFIX=any-label \
        myname/tarsnap-private /opt/backup.sh /path/to/data

This will create a backup named like this: `any-label-2016-02-21-13-41-54`. The name is made up of your `IMAGE_PREFIX` and a timestamp. The data in your container named `other_container` at `/path/to/data` will be backed up. You can specify multiple space-seperated paths.

To backup a path on the machine running Docker Daemon use something like this:

    docker run -ti --rm=true \
        --volumes-from tarsnap_cache --volume /path/to/data:/var/source-data:ro \
        --env IMAGE_PREFIX=any-label \
        myname/tarsnap-private /opt/backup.sh /var/source-data

# Listing All Backups

To get a list of the backups that have been made use a command like this:

    docker run -ti --rm=true --volumes-from tarsnap_cache myname/tarsnap-private \
        /opt/list.sh

# Restoring From a Backup

To restore the _last_ backup you made, use a command like this:

    docker run -ti --rm=true \
        --volumes-from tarsnap_cache --volumes-from other_container \
        myname/tarsnap-private /opt/restore.sh

To restore from a specific backup, use a command like this:

    docker run -ti --rm=true \
        --volumes-from tarsnap_cache --volumes-from other_container \
        myname/tarsnap-private /opt/restore.sh any-label-2016-02-21-13-41-54
