# DokuWiki Docker Container

My [DokuWiki](https://www.dokuwiki.org/dokuwiki) container image. This is
intended to be an image made for convenience of setup on any system, and comes
with everything needed to get things up and running very fast.

It uses a system similar to Docker's
[wordpress image](https://hub.docker.com/_/wordpress) where it'll only override
things during the initial setup of the image, after that the image will never
mess with any of the files in the data volume.

## Running

In order to run this container check out the included `docker-compose.yml`.

## License

This project is licensed under the
[Mozilla Public License Version 2.0](https://www.mozilla.org/en-US/MPL/2.0/).
