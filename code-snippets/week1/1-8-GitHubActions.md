# Repository to fork

https://github.com/drsylent/cubix-cloudnative-example-springboot

Take note, when you will create pull requests, the target branch should be the one in your forked repository,
not the one from which you forked!

# GitHub Actions versions

Versions for GitHub Actions must be upgraded - here are the current versions:

- checkout: @v7
- upload-artifact: @v7
- download-artifact: @v8
- setup-java: @v6

# Upload artifact snippet (watch for indentation!)

```yaml
    - name: Upload artifact for Docker job
      uses: actions/upload-artifact@v7
      with:
        name: java-app
        path: '${{ github.workspace }}/target/*.jar'
```

# Download artifact snippet (watch for indentation!)

```yaml
    - name: Download artifact from maven job
      uses: actions/download-artifact@v8
      with:
        name: java-app
```

# Docker image build for ARM machines

If you have an ARM machine, it is highly recommended, to do a multiplatform build, which enables building both ARM64 and AMD64 image building. If you don't do this and use an ARM based system, then the image will run slower (also you may need to install some compatibility layer).

Instead of this:

```yaml
   - name: Build the Docker image
    run: docker build . -t image:tag
   - name: Publishing the Docker image
    run: docker push image:tag
```

Do this:

```yaml
   - name: Set up QEMU
    uses: docker/setup-qemu-action@v4
   - name: Set up Docker Buildx
    uses: docker/setup-buildx-action@v4
   - name: Build and push the Docker image
    run: docker buildx build . --platform linux/amd64,linux/arm64 -t image:tag --push
```
