# Releasing Taylor

Create a pull request and use the following template:

```
## Releasing Taylor <VERSION>

- [ ] Prerelease
  - [ ] Create this pull request
  - [ ] Update the changelog heading
  - [ ] Update `include/version.hpp`
  - [ ] Export `taylor` and attach the builds
  - [ ] Run `taylor new` on:
    - [ ] Linux
    - [ ] Windows
    - [ ] OSX
      - [ ] ARM
      - [ ] x64
  - [ ] Export an example game and attach the builds
  - [ ] Run the example games on:
    - [ ] Linux
    - [ ] Windows
    - [ ] OSX
      - [ ] ARM
      - [ ] x64
    - [ ] Web
      - [ ] Chrome
      - [ ] Firefox
  - [ ] Export the benchmark and attach the builds
    - [ ] Linux (FPS: <RESULT>)
    - [ ] Windows (FPS: <RESULT>)
    - [ ] OSX
      - [ ] ARM (FPS: <RESULT>)
      - [ ] x64 (FPS: <RESULT>)
    - [ ] Web
      - [ ] Chrome (FPS: <RESULT>)
      - [ ] Firefox (FPS: <RESULT>)
  - [ ] Write a release blog
 [ ] Release
  - [ ] Merge this pull request
  - [ ] Tag the commit
  - [ ] Push the tag
  - [ ] Publish the blog post
  - [ ] Add a link to the migration document to the website
- [ ] Post release
  - [ ] Add an `Unreleased` section to `CHANGELOG.md`
  - [ ] Update `include/version.hpp`
```
