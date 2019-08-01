# alexfedoseev.com

## Development
To run the app locally, there are few preparation steps need to be made.

First, install dependencies:

```shell
yarn install
```

Photos from the gallery are not committed due to their size, so `src/photos/Photos.re` must be rebuilt with your own photos. You can place few sample photos in the `src/photos/files/` directory and run:

```shell
yarn run photo:generate
```

Most likely it would work without photos at all but I haven't tried.

After it's done, run 3 processes in the following order (each in own terminal):

```shell
# 1. Run bsb in watch mode
yarn run bsb:watch

# 2. Run css watcher
yarn run css:watch

# 3. Run webpack dev server
yarn run webpack:server
```
