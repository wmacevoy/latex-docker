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

- [`<dir>`/latex-base:latest](dockers/latex-base/Dockerfile)
-- CTAN TexLive Scheme-basic: Up-to-date, only basic packages, base for custom builds (500MB)
- [<dir>/latex:latest](dockers/latex/Dockerfile)
-- Created by bin/latex-docker-setup-base if missing.  Defaults to full 5GB+ install.  Customize to your needs.

Use
------------

```
cd my_latex_source

curl -L https://github.com/wmacevoy/latex-docker/tarball/master | tar zx --strip=1

bin/setup-latex-base-docker

# edit the dockers/latex/Dockerfile to decide what you want (maybe just leave full install if unsure)

# you can re-run this as many times as need be, after changing the Dockerfile for more or less stuff
bin/setup-latex-docker

# setup your context (path) for this project.  This way different projects can have different dockers...
# do this once in each terminal you are using.  (or you can use the full path bin/pdflatex, etc.)
. bin/latex-docker-context

pdflatex main.tex

More explicitly

bin/latex-docker <comand> <args..>

License
-------

See [LICENSE](LICENSE) file.
