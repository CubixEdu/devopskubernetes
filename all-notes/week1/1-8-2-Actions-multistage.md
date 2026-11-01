# Placeholders

Fill in the USERNAME in 3 files.

# Create a container locally on your computer, run it and test it

docker-run-from-local script, builds it and runs it, Ctrl+C stops it

Call with Postman

# Extend the GitHub Actions pipeline with containerization

We'll have two jobs - one which creates the JAR, one that creates the Docker container. Rename the file and the job.

Create a new job (duplicate the existing one). Call the original `maven`, the new one `docker`.

We want them to run one after the other:

```yaml
  docker:
    runs-on: ubuntu-latest
    needs: maven
```

We must pass the JAR between the jobs. Have these:

```yaml
    - name: Upload artifact for Docker job
      uses: actions/upload-artifact@v7
      with:
        name: java-app
        path: '${{ github.workspace }}/target/*.jar'
```

```yaml
    - name: Download artifact from maven job
      uses: actions/download-artifact@v8
      with:
        name: java-app
```

Then create the Docker commands. docker-publish-help.txt file has helping commands -> put in the YAML as new commands, fill the placeholders:

```yaml
    - name: Docker login
      run: docker login ghcr.io -u drsylent -p ${{ github.token }}
    - name: Build the Docker image
      run: docker build . --file Dockerfile --tag ghcr.io/drsylent/cubix/cloudnative/demo:actions
    - name: Push the Docker image
      run: docker push ghcr.io/drsylent/cubix/cloudnative/demo:actions
```

## For ARM machines

If you have an ARM machine, it is highly recommended, to do a multiplatform build, which enables building both ARM64 and AMD64 image building. If you don't do this and use an ARM based system, then the image will run slower (also you may need to install some compatibility layer).

```yaml
    - name: Docker login
      run: docker login ghcr.io -u drsylent -p ${{ github.token }}
    - name: Set up QEMU
     uses: docker/setup-qemu-action@v4
    - name: Set up Docker Buildx
     uses: docker/setup-buildx-action@v4
    - name: Build and push the Docker image
     run: docker buildx build . --file Dockerfile --platform linux/amd64,linux/arm64 --tag ghcr.io/drsylent/cubix/cloudnative/demo:actions --push
```

# Download the container, run it and test it

docker-run-from-github script - replace the placeholder

Call with Postman/Bruno.
