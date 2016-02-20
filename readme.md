# Why Tarsnap?

[Tarsnap](https://www.tarsnap.com) is a cost-effective and secure backup provider. For more information start from the [Tarsnap design detail pages](https://www.tarsnap.com/design.html) and work out if it's the service for you. If it is then go ahead and use this Docker image.

# Creating a Private Key Image

This public Tarsnap image requires a private key to securely communicate with [tarsnap.com](https://www.tarsnap.com). You should create a private Docker image based on this public Tarsnap image and keep your key in this private image. This project has a sub-directory named <code>sample-private-key-image</code> you can use as a template for this. Create your own project (and store it in a private repository) then run this command to begin creating your private key:

    docker run -ti --name=tarsnapgenkey sappho/tarsnap bash

At the Bash shell prompt type the command:

    tarsnap-keygen --keyfile /root/tarsnap.key --user me@example.com --machine mybox

Replace the <code>user</code> parameter with the email address you use to login to your [Tarsnap account](https://www.tarsnap.com/account.html) and <code>machine</code> with something personal to you, and note that it does not have to be the hostname of a machine - it can be any meaningful identifier, and it will show up under _Recent activity (one machine)_ on your Tarsnap account. After running this command type <code>exit</code> to exit the Bash shell. Then run something like this command:

    docker cp tarsnapgenkey:/root/tarsnap.key /path/to/your/private/docker/project/

This will copy the private key you've just generated into your own Dockerfile project by changing <code>/path/to/your/private/docker/project/</code> to the path to your project. Delete the container now with:

    docker rm -f tarsnapgenkey

Finally, build your customised Tarsnap image with something like this:

    docker build -t myname/myimagename /path/to/your/private/docker/project/

From this point on use your image instead of the standard <code>sappho/tarsnap</code> image.

Finally, note that you can create as many private keys, in different private images, as you like.
