#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import datetime
from jinja2 import Environment, FileSystemLoader
from os import chdir, environ, getcwd
from os.path import dirname, join, normpath, realpath
from pathlib import Path
from portage import db, root
from portage.versions import catpkgsplit, cpv_getversion

ORIG_CWD = getcwd()
WANT_DATA = ["DESCRIPTION", "HOMEPAGE"]
TEMPLATE = "template.adoc.j2"
OUTFILE = "Packages.adoc"


def initialize(repo_path):
    chdir(repo_path)
    environ["PORTDIR_OVERLAY"] = repo_path
    return db[root]["porttree"].dbapi


def cleanup(orig_cwd=ORIG_CWD):
    chdir(orig_cwd)


def gen_structure(dbapi, repo_name):
    trees = [getcwd()]
    ret = {}

    for cp in dbapi.cp_all(trees=trees):
        cpvlist = dbapi.cp_list(cp, mytree=trees)
        category, pkgname = catpkgsplit(cpvlist[0])[:2]

        cat = ret.setdefault(category, {})
        pn = cat.setdefault(pkgname, {})

        pn["data"] = dbapi.aux_get(cpvlist[-1], WANT_DATA)
        pn["versions"] = [cpv_getversion(cpv) for cpv in cpvlist]

    return ret


def gen_asciidoc(sdir, pkg_struct, template):
    env = Environment(loader=FileSystemLoader(sdir),
                      trim_blocks=True,
                      lstrip_blocks=True)

    template = env.get_template(template)
    output = template.render(env=environ,
                             now=datetime.utcnow(),
                             pkg_struct=pkg_struct)

    with open(OUTFILE, "w") as f:
        f.write(output)
        f.close()


def main():
    try:
        script_dir = dirname(realpath(__file__))
        repo_path = normpath(join(script_dir, ".."))
        portage_dbapi = initialize(repo_path)
        repo_name = (Path("profiles") / "repo_name").read_text()
        pkg_struct = gen_structure(portage_dbapi, repo_name)
        gen_asciidoc(script_dir, pkg_struct, TEMPLATE)
    finally:
        cleanup()


if __name__ == "__main__":
    main()
