# Correctomatic Cypress corrections

This container serves as base for launching Correctomatic corrections with Cypress. The container will launch the project
and run the tests. If all the tests pass, the grade will be 10, and the comments will be "Good work!" (you can configure that)
If any test fails, the grade will be 0, and the comments will be the failed tests descriptions.

## How to use

The recommended way to use this container is to develop the tests in your local machine and then create the derived
container overriding the necessary files, usually only the tests files in the `cypress` folder and the configuration file
`.env` in the root folder.

You can use this folder for developing the tests, and then create a derived container with the tests and the configuration.

### 0. Prepare the git repository

If you want to save the tests in a git repository you will need to set the remote to your repository. You can do that
with `git remote` command:

```bash
git remote rename origin correctomatic # Rename the original remote to correctomatic, in case you need to push something
git remote set-url origin <your repo url>
```

### 1. Create the tests

Install the dependencies with `yarn install` and then create a set of tests with Cypress:
```bash
yarn install
yarn cypress open
```

This will open the Cypress GUI, where you can run the tests and see the results. This **won't** launch the project, so
you will have to run it in your local machine.

You can test what will be the output of the container with the `run_tests.sh`. It will take the exercise from the
`/tmp/exercise` file, so put there the exercise you want to test.

**Currently it only allows testing a single HTML file**.

### 2. Create the derived container

Once you have the tests working, you can create a derived container with the tests and the configuration.
There is an script, `build.sh`, prepared for building the new container:

```bash
./build.sh <container-name:with-tag> <docker-options>
```

This will use the `correctomatic/cypress-correction` container as base, saving lots of time and space when creating the
derived correction.

Once the container is created you can test it with:
```bash
docker run --rm -v `pwd`/path/to/the/exercise/to/test:/tmp/exercise <container-name>
```

It should return a valid correctomatic response, with the failed tests descriptions as comments.

### Update the base container

If the base container is updated, you can fetch the changes and merge them with the derived container:
```bash
git fetch correctomatic
git merge correctomatic master
```

## Development

If you want to modify the base container, you can use the build_dev.sh script. This will build the container with the
Dockerfile.dev file, which will ignore the cypress folder and create a container with the infraestructure needed to
run the cypress tests in the child containers. It will use `latest` as tag if not specified. The docker options must be
quoted and will be passed to the `docker build` command, so you can use them to use `--no-cache`, for example.

```bash
./build_dev.sh <tag> <docker-options>
```

You can have a cypress folder with some tests to check that the base container is working correctly: the folder won't be
copyied to the base container, it's in the `.dockerignore` file. The files under the site folder won't be copied either, so
some example projects can reside there.

You can run the tests with the `run_tests.sh` script, that is the one that will be used as entrypoint. It will take the
exercise from the `/tmp/exercise` file, so put there the exercise you want to test.
