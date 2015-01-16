# Hubot Gistme

An hubot script that allow you to create Gist

## Install

- Add `hubot-gistme` to your package.json file.
- Add `hubot-gistme` to your external-scripts.json file.

## Usage

### Configure

- `GIST_ACCESS_TOKEN` - Default Github access with `gist` scope (optional)

### Sample

Create Gist

```
hubot gistme <code>
```

or you can create with filename with extension for syntax highlight (eg. hello.js)

```
hubot gistme <filename.js> <code>
```

Hubot will use `GIST_ACCESS_TOKEN` if provided. You can set your own token by

```
hubot gist-token:set <github_token>
```

or remove your token

```
hubot gist-token:reset
```

