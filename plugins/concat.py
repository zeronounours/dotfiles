import os
import glob
import shutil
from dotbot.plugin import Plugin
from dotbot.plugins.link import Link


class Concat(Plugin):
    """Concat the files in a directory into a single file

    Concat takes as argument a dict {destination file ==> source}

    source can be.
        - a string: in that case, it should be the path to the directory
          to concat
        - a dict which may contains the keys:
            * path: path to the directory. Default: null (automatic)
              It can also be a list of path.
            * glob: if true treat path as a globing expression to match
              all files to concat. Globbing only resolve to files, unless
              the pattern ends with "/". In that case, it only resolve to
              directories. Default: False
            * create: if true, create all parent directories.
              Default: False

    Sources are concatenated in the order of the path list and for each
    directory and globbing, in the alphanumeric order.

    Both source and destination can be relative to the base directory.

    If no path is given, the source is considered to be a directory
    named after the destination, with a ".d" appended.
    """
    _directive = "concat"

    def __init__(self, context):
        super().__init__(context)


    def can_handle(self, directive):
        return directive == self._directive


    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Concat cannot handle directive %s" % directive)
        return self._process(data)


    def _process(self, data):
        success = True
        defaults = self._context.defaults().get("concat", {})
        # data is a dict {destination ==> source}
        for destination, source in data.items():
            # expand destination
            destination = os.path.expandvars(os.path.expanduser(destination))

            # option resolution
            #   Possible options are:
            #       - path
            #       - glob
            #       - create
            use_glob = defaults.get("glob", False)
            create = defaults.get("create", False)
            # source can be a dict with specified options
            # or a string which is the path
            if isinstance(source, dict):
                # extended config
                use_glob = source.get("glob", use_glob)
                create = source.get("create", create)
                paths = self._default_source(destination, source.get("path"))
            else:
                paths = self._default_source(destination, source)

            # paths can be a list of string a string
            # normalize to a list of string
            if not isinstance(paths, list):
                paths = [paths]

            # resolve all paths to files, respecting the order
            all_paths = []
            for path in paths:
                all_paths.extend(self._resolve_path(path, use_glob))

            # concat all files
            if create:
                success &= self._create(destination)
            success &= self._concat(destination, all_paths)

        if success:
            self._log.info("All files have been concatenated")
        else:
            self._log.error("Some files were not successfully concatenated")
        return success


    def _resolve_path(self, path, use_glob):
        """resolve a path to a list of files"""
        # expand variables
        epath = os.path.expandvars(os.path.expanduser(path))

        # expand with glob is asked for
        if use_glob:
            self._log.debug("Globbing with path: " + str(epath))
            glob_results = glob.glob(epath)

            # globbing failed
            if len(glob_results) == 0:
                self._log.debug("Globbing couldn't find anything matching")
                # if globbing does not expand, we use the original
                # string like in shells
                all_paths = [epath]
            elif epath[-1] == os.sep:
                # if pattern ends with "/", glob already resolve to
                # directories only
                all_paths = glob_results
                all_paths.sort(key=self._sort_basename)
            else:
                # if pattern does not end with "/", we must filter on
                # files only
                all_paths = []
                for p in glob_results:
                    if os.path.isfile(p):
                        all_paths.append(p)
                # if no files was resolved with globbing, do the same
                # as if glob failed
                if len(all_paths) == 0:
                    self._log.debug("Globbing couldn't find any matching file")
                    all_paths = [epath]
                else:
                    all_paths = all_paths
                    all_paths.sort(key=self._sort_basename)
        else:
            # normalize to a list as globbing do
            all_paths = [epath]

        # Finally resolve directories to a list of files
        # even if a directory is the result of globbing
        ret = []
        for p in all_paths:
            if os.path.isfile(p):
                # keep all files
                ret.append(p)
            elif os.path.isdir(p):
                dirs = os.listdir(p)
                dirs.sort(key=self._sort_basename)
                # expand directories to first-level files
                for q in dirs:
                    full_p = os.path.join(p, q)
                    if os.path.isfile(full_p):
                        ret.append(full_p)

        self._log.debug("Resolved %s to %r" % (path, ret))
        return ret


    @staticmethod
    def _sort_basename(name):
        """Method to get the basename of files and directories to sort"""
        return os.path.basename(name.rstrip(os.sep))


    def _default_source(self, destination, source):
        if source is None:
            basename = os.path.basename(destination)
            return basename + ".d"
        else:
            return source

    def _create(self, path):
        success = True
        parent = os.path.abspath(os.path.join(path, os.pardir))
        if not os.path.exists(parent):
            self._log.debug("Try to create parent: " + str(parent))
            try:
                os.makedirs(parent)
            except OSError:
                self._log.warning("Failed to create directory %s" % parent)
                success = False
            else:
                self._log.lowinfo("Creating directory %s" % parent)
        return success

    def _concat(self, destination, paths):
        success = True
        try:
            with open(destination, "w") as outfile:
                for p in paths:
                    try:
                        with open(p, "r") as infile:
                            # read line by line for large files
                            for line in infile:
                                outfile.write(line)
                    except OSError:
                        self._log.warning("Failed to read file %s" % p)
                        success = False
        except OSError:
            self._log.error("Failed to write file %s" % destination)
            success = False
        return success
