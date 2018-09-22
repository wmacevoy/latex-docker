Latex docker container 
======================

This container helps compiling latex sources without the need to install all latex packages on your system, and keeps those containers
on a per-project basis, so old and new package dependencies do not conflict.

Why should I use this container?
-----
- Preserves UID and GID of local user
- Use container like local command: `pdflatex main.tex`
- Core `texlive`, default to full or customize for your needs
- Directory-based dockers, so your tex can be different in different projects
- You maintain the fork - no reliance on me
- You edit dockers/latex/Dockerfile, which this repo does not overwrite
- Change of dependencies? Just change your docker and re-run bin/setup-latex-docker

Versions
--------
Version is based on ubuntu xenial:

- [`<dir>/latex-base:latest`](dockers/latex-base/Dockerfile)
-- CTAN TexLive Scheme-basic: Up-to-date, only basic packages, base for custom builds (500MB)
- [`<dir>/latex:latest`](dockers/latex/Dockerfile)
-- Created by bin/latex-docker-setup-base if missing.  Defaults to full 5GB+ install.  Customize to your needs.

Use
------------

If you want to use in an existing latex project,
```bash
cd my_latex_source
curl -L https://github.com/wmacevoy/latex-docker/tarball/master | tar zx --strip=1
```
Alternatively, you could clone a fork of this repository for a new latex project
```bash
git clone my_latex_project.git
cd my_latex_project
```

After untarring/forking, you can buid the base docker with
```bash
bin/latex-docker-setup-base
```
If you want less than the full texlive, you can edit `dockers/latex/Dockerfile` to decide what you want.

The first time, and after any changes to the Dockerfile(s), you can re-create them and hooks for them with
```bash
bin/setup-latex-docker
```

Once the dockers are created, you can adjust your path in the current shell to use the dockerized commands with
```bash
. bin/latex-docker-context
```
After this you can run commands directly, for example:
```bash
pdflatex main.tex
latex-docker <command> <args>...
```
or directly (even without the context path setting) as
```bash
bin/latex-docker <command> <args>...
```

Customize
---------

If you are missing files, you can add RUN commands in the `dockers/latex/Dockerfile` and re-run bin/latex-docker-setup to refresh the container.  If you append additions the updates should be fast.

License
-------

See [LICENSE](LICENSE) file.
