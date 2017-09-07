alpine-hugo for circleci deploy
include awscli and git

`.circleci/config.yml`
```
version: 2
jobs:
  build:
    docker:
      - image: amothic/alpine-hugo:latest
    working_directory: ~/project
    steps:
      - checkout
      - run:
          name: Build
          command: |
            hugo
      - run:
          name: Sync S3
          command: |
            aws s3 sync public s3://< your bucket name >/ --delete
      - run:
          name: Create invalidation to cloudfront
          command: |
            aws configure set preview.cloudfront true
            aws cloudfront create-invalidation --distribution-id < your distribution id > --paths "/*"
```
