# Simple Docker Workflow

This workflow is a simple example of how to build and push a Docker image to DockerHub using GitHub Actions.

## Workflow

```yaml
name: Build and Publish Docker Image

on:
  push:
    branches:
      - 'main'

env:
  DOCKER_IMAGE: 4lch4/simple-docker-workflow

jobs:
  build-and-push:
    name: Build & Push Docker Image
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Extract metadata (tags, labels) for Docker
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.DOCKER_IMAGE }}
          tags: |
            latest
            ${{ github.sha }}
            ${{ github.ref }}
            ${{ github.repository }}:latest

      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build & Push to DockerHub
        id: build
        uses: docker/build-push-action@v4
        with:
          context: .
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          push: true
```
