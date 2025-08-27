# Latex docker container

## What

TexLive docker management

## Why

- Simple. Use dockerized commands just like normal: `pdflatex main.tex`
- Versioned.  Each project uses their own packages.  No conflicts
- Maintainable. You can add updates to the base without losing your changes
- Shareable.  Your project folder contains how to build your documents.
- Secure.  You decide what is in the Docker - no reliance on me

## Use

### Step 1/new - For new projects

Fork this repository, rename it to what you want, and clone it locally.

### Step 1/used - For existing projects

If you want to use in an existing latex project, or update an existing project with the new base (this does not effect your customizations):

In the root of your latex project, copy the following:
```bash
curl -L https://github.com/wmacevoy/latex-docker/tarball/master | tar zxv --strip=1 '*/bin' '*/dockers'
```
If this reports an error about `Use --wildcards to enable pattern matching`, then try
```bash
curl -L https://github.com/wmacevoy/latex-docker/tarball/master | tar zxv --strip=1 --wildcards '*/bin' '*/dockers'
```
instead.

You should be able to do this anytime you want to encorporate an update without harming any of your files, including your
custom latex docker in `dockers/latex/Dockerfile`.  This does over-write the following files:

    bin/latex-docker
    bin/latex-docker-command
    bin/latex-docker-context-
    bin/latex-docker-uncontext-    
    bin/latex-docker-rebuild
    bin/latex-docker-setup
    bin/latex-docker-setup-base
    dockers/latex-base/Dockerfile
    dockers/latex/Dockerfile.* (example templates)

### Step 2 - context (deprecated)

The commands in the bin folder can be executed explicitly from any working directory.  However the project bin is added to the front of your PATH with [**NOTICE DOT**]
```bash
. bin/latex-docker-context
```
in a terminal.  This command removes any occurances of the path first, so you can source context repeatedly.

Deprecated: the setup puts too many things in the container context (like ls).  Just run the high level commands like `bin/make` or `bin/pdflatex` which will invoke the container environment.

Sourcing uncontext,
```bash
. bin/latex-docker-uncontext
```
removes it.

### Step 3 - setup base

After untarring/forking, build the base docker with
```bash
bin/latex-docker-setup-base
```
By default the base image uses a Debian suite and installs TeX Live via apt for reproducibility. You can override these at build time:

```bash
# optional overrides
export DEBIAN_SUITE=bookworm      # or trixie, etc.
export TL_PACKAGES="texlive-full asymptote latexmk xindy"  # apt package list

bin/latex-docker-setup-base
```

If you don't already have one, this also creates a default `dockers/latex/Dockerfile` you can customize in the next step.

### Step 4 - customize (optional, but very good idea)

Edit the `dockers/latex/Dockerfile` file to decide what you want.  You don't have to get it right the first time.

**DO NOT** change the first FROM line - this was written specifically by setup-base so your dockers are project specific - they are named according to the folder of the project they are in.

It can be tempting to just leave a "full" TeX Live. However, that’s large and slow for collaborators. Favor a smaller set via apt packages using the `TL_PACKAGES` override above. You can iterate quickly by adjusting the package list and re-running setup.

### Step 5 - setup

You can repeat this step as often as you like (after any updates to your project dockers).  

```bash
bin/latex-docker-setup
```

This rebuilds the container and creates a number of symbolic links in your `bin` folder to all the texlive commands found in the container `PATH`. These link files are appended to `bin/.gitignore` if not already present.

With the links you can run texlive commands directly, like

```bash
bin/pdflatex paper.tex
```

Alternatively,

```bash
bin/latex-docker <command...>
```

### Step 6 - customize (again)

If you started from the minimum, you will have customize/setup several times before everything works.  This is a good thing from the point of keeping future installs fast, small, portable and maintainable.  Your future self and collaborators will thank you (well maybe at least not curse you compared to `scheme-full`)

Helpful hints:

- Prefer apt packages for TeX Live (`TL_PACKAGES`) over using `tlmgr` in image builds; this keeps the base reproducible and compatible with Debian’s TeX Live. You can still use `tlmgr` inside the container for diagnostics (e.g., `tlmgr search --global --file <thing>`), but install packages via apt.
- The docker build caches `RUN` steps, so iterate by adjusting `TL_PACKAGES` or appending additional `RUN apt-get install ...` lines as needed, then consolidate later. Sort lists alphabetically to make maintenance easier.

### Step 7 - version control

If you are using git, copy the following commands:
```bash
git add bin/.gitignore bin/latex-docker bin/latex-docker-command bin/latex-docker-setup-base bin/latex-docker-setup dockers/latex-base/Dockerfile dockers/latex/Dockerfile dockers/latex/Dockerfile.*[a-z0-9]
git commit -m 'update latex-docker'
```
Alternatively, if you want the latest updates from this master and rebuild everything and commit it,
```bash
bin/latex-docker-rebuild
```

## Use

If your project is using this framework, you and your collaborators should able to

- install docker
- clone your project 
- run `bin/latex-docker-setup` in a bash shell (docker cli shell in windows, just a bash shell for everyone else)
- find something to do for a few hours if you decided on scheme-full

After this, any time they want to work on the project,

- source (**NOTICE DOT**) `. bin/latex-docker-context` to setup their path in the terminal they are using.
- use the texlive commands, `pdflatex paper.tex` etc.

### Tests and reproducibility

- The tufte test at `tests/tufte/run` uses a checked-in snapshot by default for stability. To test against the latest upstream, set `USE_REMOTE_TUFTE=1` in the environment.
- If LaTeX refuses to overwrite an existing PDF (e.g., "I can't write on file ..."), remove the existing PDF first. The test script does this automatically.

## FAQ

Q. I need to install X.  But after I install X it still seems to be missing.

A. After building the container, its content is fixed.  Append a  `RUN` command in `dockers/latex/Dockerfile` and re-run `bin/latex-docker-setup`.  Use tlmgr to query, but installs happen in the Dockefile.  (This is a good thing, your Dockerfile should have everything to build your project with so it is maintainable).

Q. There are errors about missing fonts / packages.

A. Search for the error on the internet along with "texlive" and perhaps "debian".  The hints that show up try adding to your Dockerfile as a `RUN` command.  If they fail you can just remove them.  Update the commands with `bin/latex-docker-setup`

Q. I created/fixed a Dockerfile for X

A. Fork this, create "dockers/latex/Dockerfile.X" with some helpful comments and make a pull request.

## Thanks

Thanks to Benedikt Lang <github at benediktlang.de> [https://github.com/blang/latex-docker](https://github.com/blang/latex-docker) for the foundations of this project.

## License

See [LICENSE](LICENSE) file.
