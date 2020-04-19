import os
import sys
import urllib
import shutil
from dotbot.plugin import Plugin


class Download(Plugin):
    """Download a file on the internet to the destination

    Concat takes as argument a dict {destination file ==> source}

    source can be.
        - a string: in that case, it should be the URL of the file to
          download
        - a dict which may contains the keys:
            * url: URL of the file to download. Required
            * create: if true, create all parent directories.
              Default: False
            * force: if true, the file will be downloaded everytime dotbot
              is lauched. Default: False

    Destination can be relative to the base directory.

    If the destination file already exists and force is false, no
    download will happen
    """
    _directive = "download"

    def can_handle(self, directive):
        return directive == self._directive


    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Download cannot handle directive %s" % directive)
        return self._process(data)


    def _process(self, data):
        success = True
        defaults = self._context.defaults().get("download", {})
        # data is a dict {destination ==> source}
        for destination, source in data.items():
            # expand destination
            destination = os.path.expandvars(os.path.expanduser(destination))

            # option resolution
            #   Possible options are:
            #       - path
            #       - glob
            #       - create
            create = defaults.get("create", False)
            force = defaults.get("force", False)
            # source can be a dict with specified options
            # or a string which is the path
            if isinstance(source, dict):
                # extended config
                create = source.get("create", create)
                force = source.get("force", force)
                url = source.get("url")
            else:
                url = source

            # create parent
            if create:
                success &= self._create(destination)
            # download only if needed
            if os.path.exists(destination):
                self._log.info("Skip download: %s already exists" % destination)
            else:
                self._log.info("Download %s" % url)
                success &= self._download(destination, url)

        if success:
            self._log.info("All files have been downloaded")
        else:
            self._log.error("Some files were not successfully downloaded")
        return success


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

    def _download(self, destination, url):
        success = True
        if sys.version_info >= (3, 0):
            # need to import subpackges
            import urllib.request
            import urllib.error
            # do the download
            try:
                urllib.request.urlretrieve(url, destination)
            except urllib.error.URLError:
                self._log.error("Failed to download %s" % url)
                success = False
            except OSError:
                self._log.error("Failed to write file %s" % destination)
                success = False
        else:
            # do the download
            try:
                urllib.urlretrieve(url, destination)
            except:
                self._log.error("Failed to download %s" % url)
                success = False
        return success
