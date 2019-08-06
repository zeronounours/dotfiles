import os
from dotbot.plugin import Plugin


class Env(Plugin):
    """Defines or redefines environment variables

    env takes as argument a dict {env variable ==> value}
    value is expanded with available environment variables
    """
    _directive = "env"

    def can_handle(self, directive):
        return directive == self._directive


    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Env cannot handle directive %s" % directive)
        return self._process(data)


    def _process(self, data):
        if not isinstance(data, dict):
            self._log("Invalid data type given to env: %s" % type(data))
            return False

        # data is a dict {var ==> value}
        for var, val in data.items():
            self._log.debug("Set environment variable %s to %s" % (var, val))
            os.environ[var] = os.path.expandvars(val)
        return True

