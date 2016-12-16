# Activiti in Docker

# Table of Contents
- [Introduction](#introduction)
    - [Version](#version)
    - [Changelog](Changelog.md)
- [Installation](#installation)
- [Quickstart](#quickstart)
- [Configuration](#configuration)
  - [Database](#database)
  - [Available Configuration Parameters](#available-configuration-parameters)

# Introduction

Dockerfile to build an [Activiti BPM](#http://www.activiti.org/) container image.

## Version

Current Version: 6.0.0.Beta4

# Installation
1. Create the container network with `network-create.sh`.
2. Set up a DB container and set its properties in assets/db.properties
3. Set this container up
  - Pull the latest version of the image from the docker index. This is the recommended method of installation as it is easier to update image in the future. These builds are performed by the **Docker Trusted Build** service.

```bash
docker pull kentoj/activiti:latest
```

Since version `latest`, the image builds are being tagged. You can now pull a particular version of activiti by specifying the version number. For example,

```bash
docker pull kentoj/activiti:6.0.0.Beta4
```

Alternately you can build the image yourself.

```bash
git clone https://github.com/kentoj/activiti.git
cd activiti
docker build --tag="$USER/activiti" .
```

# Quickstart

Run the activiti image

```bash
docker run --name='activiti' -it --rm \
-p 8080:8080 \
-v /var/run/docker.sock:/run/docker.sock \
-v $(which docker):/bin/docker \
eternnoir/activiti:latest
```

Point your browser to `http://localhost:8080` and login using the default username and password:

* username: **kermit**
* password: **kermit**

You should now have the Activiti application up and ready for testing. If you want to use this image in production the please read on.


# Configuration

## Database

Activiti uses a database backend to store its data. The main difference between this image and the eternoir/activiti image is that it does not automatically set up a DB container.

### PostgreSQL

#### External PostgreSQL Server

The image is configured to use an external PostgreSQL. To create the volume and the container needed for the PostgreSQL container
run the `postgres-container-create` script. This depends on the `network-create.sh` script.

Before you start the Activiti image create user and database for activiti.



We are now ready to start the Activiti application.

run the `docker-run.sh` command.

#### Linking to PostgreSQL Container

The containers are visible to each other through the Docker network called my-activiti-network



### Available Configuration Parameters

*Please refer the docker run command options for the `--env-file` flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command.*

Below is the complete list of available options that can be used to customize your activiti installation.

- **TOMCAT_ADMIN_USER**: Tomcat admin user name. Defaults to `admin`.
- **TOMCAT_ADMIN_PASSWORD**: Tomcat admin user password. Defaults to `admin`.
- **DB_HOST**: The database server hostname. Defaults to ``.
- **DB_PORT**: The database server port. Defaults to `5432`.
- **DB_NAME**: The database database name. Defaults to ``.
- **DB_USER**: The database database user. Defaults to ``.
- **DB_PASS**: The database database password. Defaults to ``.


# Administration
Add the following records into the database to enable an admin account:

```
INSERT INTO public.act_id_group (id_, rev_, name_, type_) VALUES ('ROLE_ADMIN', 1, 'Superusers', 'security-role');
INSERT INTO public.act_id_user (id_, rev_, first_, last_, email_, pwd_, picture_id_) VALUES ('admin', 1, 'null', 'Administrator', 'admin@activiti.example.com', 'test', null);
INSERT INTO public.act_id_membership (user_id_, group_id_) VALUES ('admin', 'ROLE_ADMIN');
```



# Maintenance

## Shell Access

For debugging and maintenance purposes you may want access the container shell. Since the container does not allow interactive login over the SSH protocol, you can use the [nsenter](http://man7.org/linux/man-pages/man1/nsenter.1.html) linux tool (part of the util-linux package) to access the container shell.

Some linux distros (e.g. ubuntu) use older versions of the util-linux which do not include the `nsenter` tool. To get around this @jpetazzo has created a nice docker image that allows you to install the `nsenter` utility and a helper script named `docker-enter` on these distros.

To install the nsenter tool on your host execute the following command.

```bash
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
```

Now you can access the container shell using the command

```bash
sudo docker-enter my_activiti
```

For more information refer https://github.com/jpetazzo/nsenter

Another tool named `nsinit` can also be used for the same purpose. Please refer https://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/ for more information.

# Upgrading

TODO

# References

* https://github.com/eternnoir/activiti
* http://activiti.org/
* http://github.com/Activiti/Activiti
* http://tomcat.apache.org/
* https://hub.docker.com/_/postgres/
* https://github.com/jpetazzo/nsenter
* https://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/

